#!/bin/sh

# Run this script via cronjob to update your metadata mirror

METADATA_MIRROR_DIR=/path/to/your/mirror/dir

# METADATA_MIRROR_DIR must contain:
#  * a folder $overlay/ for each overlay you intent to mirror.
#  * a folder cache/ to store the cache of all overlays.
#    (so it is not mixed with the cache of your system portage-trees)
# METADATA_MIRROR_DIR/$overlay/ must contain:
#  * a file etc/make.conf with following contents:
#    PORTDIR=/your/portage/directory
#    PORTDIR_OVERLAY=/path/to/your/mirror/dir/$overlay/repo
#    FEATURES="${FEATURES} userpriv userfetch usersandbox usersync metadata-transfer"
#  * a directory repo/ containing the checked out repository you want to create metadata from.
# For speed reasons it is advisable to have a file etc/portage/modules containing:
#    portdbapi.auxdbmodule = portage.cache.sqlite.database

die() {
        echo "Usage: $0 <overlay>" 1>&2
        echo "ERROR: $@" 1>&2
        exit 255
}

[[ "$1" ]] || die 'overlay'
overlay="$1" ; shift

case $overlay in
	kde) update="git --git-dir=$METADATA_MIRROR_DIR/kde/repo/.git/ pull" ;;
	*) die "unknown overlay: $overlay" ;;
esac

if $update ; then
	exec egencache --config-root=$METADATA_MIRROR_DIR/$overlay/ --cache-dir=$METADATA_MIRROR_DIR/cache/ --repo=$overlay --update
fi
