#!/bin/bash

# Run this script via cronjob to update your overlay mirror

GENTOO_MIRROR_DIR=/var/gentoo
GENTOO_PORTAGE_DIR=/var/gentoo/portage

# GENTOO_MIRROR_DIR must contain:
#  * a directory overlay-repos/$overlay for each overlay you intend to mirror:
#    It shall contain the checked out overlay repository.
#    Git repositories must be named "overlay-repos/${overlay}.git".
#    SVN repositories must contain a directory "overlay-repos/${overlay}/.svn".
# Directories and files within OVERLAY_MIRROR_DIR that will be created by this script:
#  * overlays/$overlay/ contains the overlays suitable to sync with rsync.
#  * overlay-etc/$overlay/ contains a portage config necessary to generate the caches.
#  * cache/ to store the intermediate cache of all overlays.
#    (so it is not mixed with the cache of your system portage-trees)
#  * etc/portage/ containing following files:
#     * etc/portage/make.conf:
#       PORTDIR=/your/portage/directory
#       FEATURES="${FEATURES} userpriv userfetch usersandbox usersync metadata-transfer"
#       NOCOLOR=true
#     * etc/portage/modules:
#       portdbapi.auxdbmodule = portage.cache.sqlite.database
#       (for speed reasons)
#    (files in this directory are not changed if they exist)

PORTAGE_CONFIGROOT="${GENTOO_MIRROR_DIR}"
PORTAGE_DEPCACHEDIR="${GENTOO_MIRROR_DIR}/cache"

die() {
	echo "USAGE: $0 <overlay>" 1>&2
	echo "ERROR: $@" 1>&2
	exit 1
}

[[ "$1" ]] || die 'overlay'
overlay="$1" ; shift

overlay_dir="${GENTOO_MIRROR_DIR}/overlays/${overlay}"
overlay_repo_dir="${GENTOO_MIRROR_DIR}/overlay-repos/${overlay}"

if [ -e "${overlay_repo_dir}/.svn" ] ; then
	type=svn
elif [ -e "${overlay_repo_dir}.git" ] ; then
	type=git
	overlay_repo_dir="${overlay_repo_dir}.git"
else
	die "Unable to determine overlay type for $overlay"
fi

echo 'Updating overlay ...'
case "$type" in
	svn)
		svn cleanup "${overlay_repo_dir}" || die 'svn cleanup failed'
		svn update --force "${overlay_repo_dir}" || die 'svn update failed'
		;;
	git)
		git --git-dir="${overlay_repo_dir}" fetch || die 'git update failed'
		;;
	*)
		die "Unsupported overlay type '$type' for $overlay"
		;;
esac

mkdir -p "${GENTOO_MIRROR_DIR}/overlays" || die 'failed to create overlays/ dir'
mkdir -p "${GENTOO_MIRROR_DIR}/etc/portage/" || die 'failed to create etc/portage/ dir'

if [ -! -e "${GENTOO_MIRROR_DIR}/etc/portage/make.conf" ] ; then
	cat <<- EOF > "${GENTOO_MIRROR_DIR}/etc/portage/make.conf"
		PORTDIR=${GENTOO_PORTAGE_DIR}
		FEATURES="\${FEATURES} userpriv userfetch usersandbox usersync metadata-transfer"
		NOCOLOR=true
	EOF
fi
if [ -! -e "${GENTOO_MIRROR_DIR}/etc/portage/modules" ] ; then
	cat <<- EOF > "${GENTOO_MIRROR_DIR}/etc/portage/modules"
		portdbapi.auxdbmodule = portage.cache.sqlite.database
	EOF
fi

if [ -e "${overlay_dir}.tmp" ] ; then
	echo 'Removing old export ...'
	rm -fr "${overlay_dir}.tmp"
fi

echo 'Exporting overlay ...'
case "$type" in
	svn)
		svn export --force --config-option=config:miscellany:use-commit-times=yes "${overlay_repo_dir}" "${overlay_dir}.tmp" || die 'svn export failed'
		;;
	git)
		mkdir -p "${overlay_dir}.tmp" || die 'creating export dir failed'
		git --git-dir="${overlay_repo_dir}" archive master | tar -x -C "${overlay_dir}.tmp" || die 'git export failed'
		;;
	*)
		die "Unsupported overlay type '$type' for $overlay"
		;;
esac

cd "${overlay_dir}.tmp" || die "failed to cd to ${overlay_dir}.tmp"

overlay_name="$(< profiles/repo_name)"
[[ "$overlay_name" ]] || die 'overlay_name'

overlay_configroot="${GENTOO_MIRROR_DIR}/overlay-etc/${overlay}"
mkdir -p "${overlay_configroot}/etc/portage" || die 'creating overlay configroot failed'
cat <<- EOF > "${overlay_configroot}/etc/portage/make.conf" || die 'creating overlay make.conf failed'
	source ${PORTAGE_CONFIGROOT}/etc/portage/make.conf
	PORTDIR_OVERLAY=${overlay_dir}.tmp
EOF
ln -sfn "${PORTAGE_CONFIGROOT}/etc/portage/modules" "${overlay_configroot}/etc/portage/" || die 'creating overlay modules symlink failed'

PORTAGE_CONFIGROOT="${overlay_configroot}"
PORTDIR_OVERLAY="${overlay_dir}.tmp"

export PORTAGE_CONFIGROOT PORTAGE_DEPCACHEDIR PORTDIR_OVERLAY

echo 'Enforcing full manifests ...'
#sed -e 's/^thin-manifests.*/thin-manifests = false/' -i metadata/layout.conf || die 'patching layout.conf failed'

echo 'Generating manifests ...'
#repoman manifest || die 'generating manifests failed'

echo 'Generating metadata caches ...'
egencache --config-root="${PORTAGE_CONFIGROOT}" --cache-dir="${PORTAGE_DEPCACHEDIR}" --portdir-overlay="${PORTDIR_OVERLAY}" --repo=$overlay_name --update || die 'generating metadata caches failed'

echo 'Moving export into place ...'
mv -T "${overlay_dir}" "${overlay_dir}.old"
mv -T "${overlay_dir}.tmp" "${overlay_dir}" || die 'moving export failed'
rm -fr "${overlay_dir}.old"
