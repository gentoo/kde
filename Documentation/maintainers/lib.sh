#!/bin/bash

# Requires:
# app-portage/portage-utils
# app-portage/gentoolkit-dev
# dev-util/pkgcheck
# dev-util/pkgdev
# sys-apps/coreutils
# Optional:
# dev-vcs/git

: ${SOURCE_REPO:="$(realpath $(dirname $0)/../../)"}

: ${TARGET_REPO:="${SOURCE_REPO}"}

# @FUNCTION: bump_packages_from_set
# @USAGE: <set name> <source version> <target version>
# @DESCRIPTION:
# Using packages listed in <set name>, bump new <target version> ebuilds based on
# <source version>
bump_packages_from_set() {
	local setname="${1}"
	local sourceversion="${2}"
	local targetversion="${3}"
	local mainversion="$(main_version ${targetversion})"

	local packages=$(get_package_list_from_set ${setname})

	for cp in ${packages} ; do
		trap "echo Exited without finishing!; exit;" SIGINT SIGTERM
		pushd "${cp}" > /dev/null

		local pn=$(basename $(pwd))
		local source=${pn}-${sourceversion}.ebuild
		local destination=${pn}-${targetversion}.ebuild

		cp ${source} ${destination}
		ekeyword ^all ${destination} > /dev/null

		if [[ ${destination} != *9999* ]] ; then
			ekeyword $(get_main_tree_keyword ${cp} ${mainversion}) ${destination} > /dev/null
			ekeyword ~all ${destination} > /dev/null
		fi

		if [[ -n "${KFMIN}" ]] ; then
			sed -e "/^KFMIN/s/=.*/=${KFMIN}/" -i ${destination}
		fi

		pkgdev manifest

		popd > /dev/null
	done
}

# @FUNCTION: bump_set_from_live
# @USAGE: <base set name> <new version>
# @DESCRIPTION:
# Creates new set <base setname>-<new version> based on <base setname>-live.
bump_set_from_live() {
	local target="${1}"
	local destination="${2}"

	cp "${SOURCE_REPO}"/sets/${target}-live "${SOURCE_REPO}"/sets/${target}-${destination}
	sed -E "s/^~/</;/^#/! s/[0-9]+(\.[0-9]+)*(\:.*)*$/${destination}.50\2/" \
		-i "${SOURCE_REPO}"/sets/${target}-${destination}
	sed -e "/^@/s/live$/${destination}/" \
		-i "${SOURCE_REPO}"/sets/${target}-${destination}
		

	for entry in $(grep ^@ "${SOURCE_REPO}"/sets/${target}-live) ; do
		entry=${entry/-live/}
		bump_set_from_live ${entry/@/} ${destination}
	done
}

# @FUNCTION: commit_packages
# @USAGE: <set name> <commit msg>
# @DESCRIPTION:
# Commit set of packages iterating over <set name>.
commit_packages() {
	local setname="${1}"
	local commitmsg="${2}"
	local cp packages

	if ! { [[ -d "${TARGET_REPO}/.git" ]] && hash git 2>/dev/null; } then
		echo "${FUNCNAME[0]}: error: only commits to git repositories!"
		return
	fi

	packages=$(get_package_list_from_set ${setname})
	for cp in ${packages} ; do
		pushd "${TARGET_REPO}/${cp}" > /dev/null

		git add .
		pkgdev commit . -m "${commitmsg}"

		popd > /dev/null
	done

	if hash pkgcheck 2>/dev/null; then
		pushd "${TARGET_REPO}" > /dev/null
			pkgcheck scan --commits
		popd > /dev/null
	fi
}

# @FUNCTION: create_keywords_files
# @USAGE: <target set> <base setname>
# @DESCRIPTION:
# Creates new package.{accept_keywords,unmask,mask}/<target set> files based on
# <base setname>-live dirs and referencing <target setname> including any subsets.
create_keywords_files() {
	local target="${1}"
	local base="${2}"
	local x

	if [[ $# -gt 2 ]]; then
		echo "${FUNCNAME[0]}: error: must be passed exactly one argument!"
		return
	fi

	pushd "${SOURCE_REPO}"/Documentation/package.unmask > /dev/null
		cp -r .${base}-live .${target}
		pushd .${target} > /dev/null
			rm *-live
			ln -s ../../../sets/${target} ${target}
			for x in $(grep ^@ ../../../sets/${target}); do
				ln -s ../../../sets/${x/@/} ${x/@/}
			done
			echo "# You can use this file to mask/unmask the $(pretty_setname ${target}) release." > _HEADER_
			echo "# Edit Documentation/package.unmask/.${target}/ files instead." >> _HEADER_
		popd > /dev/null
	popd > /dev/null

	pushd "${SOURCE_REPO}"/Documentation/package.accept_keywords > /dev/null
		cp -r .${base}-live.base .${target}
		pushd .${target} > /dev/null
			rm *-live
			ln -s ../../../sets/${target} ${target}
			for x in $(grep ^@ ../../../sets/${target}); do
				ln -s ../../../sets/${x/@/} ${x/@/}
			done
			echo "# You can use this file to keyword/unkeyword the $(pretty_setname ${target}) release." > _HEADER_
			echo "# Edit Documentation/package.accept_keywords/.${target}/ files instead." >> _HEADER_
		popd > /dev/null
	popd > /dev/null
}

# @FUNCTION: get_main_tree_keyword
# @USAGE: <cp> [<main version>]
# @DESCRIPTION:
# Given a <cp>, get the keywords from the highest ebuild version in the gentoo repo.
# If given also <main version>, prefer the keywords from existing main version branch.
get_main_tree_keyword() {
	local portdir="$(portageq get_repo_path / gentoo)"
	local cp="${1}"
	local mv="${2}"
	local checkpath="${portdir}/${cp}/${cp##*/}"

	if [[ -n ${mv} ]] && compgen -G "${checkpath}-${mv}*.ebuild" >/dev/null 2>&1; then
		checkpath+="-${mv}"
	fi
	echo $(sed -ne 's/^\s*KEYWORDS="\(.*\)"/\1/p' "$(ls ${checkpath}*.ebuild | sort | tail -n 1)")
}

# @FUNCTION: get_package_list_from_set
# @USAGE: <set name>
# @DESCRIPTION:
# Given a <set name>, return all atoms with the version stripped.
get_package_list_from_set() {
	local set="${1}"

	for entry in $(grep -v ^[#@] "${SOURCE_REPO}/sets/${set}") ; do
		echo $(qatom ${entry} | cut -d " " -f 1-2 | tr " " "/")
	done

	for entry in $(grep ^@ "${SOURCE_REPO}/sets/${set}") ; do
		get_package_list_from_set ${entry/@/}
	done
}

# @FUNCTION: main_version
# @USAGE: <pv>
# @DESCRIPTION:
# Given a <pv> version string, get the first and second part (x.y.z -> x.y).
main_version() {
	local pv="${1}"

	if [[ $# -gt 1 ]]; then
		echo "${FUNCNAME[0]}: error: must be passed exactly one argument!"
		return
	fi

	echo ${pv} | cut -d "." -f 1-2
}

# @FUNCTION: mark_unreleased
# @USAGE: <category> <version>
# @DESCRIPTION:
# Marks a <version> as unreleased in <category>.kde.org.eclass.
mark_unreleased() {
	local category="${1}"
	local version="${2}"
	sed -e "/^KDE_PV_UNRELEASED/s/ )/ ${version}&/" \
		-i "${SOURCE_REPO}"/eclass/"${category}".kde.org.eclass
}

# @FUNCTION: mask_from_set
# @USAGE: <base set> <target version> <filename>
# @DESCRIPTION:
# Takes sets/<base set>, transforming it a profiles/package.mask/<filename>
# list of atoms with <target version>.
mask_from_set() {
	local set="${1}"
	local version="${2}"
	local filename="${3}"
	local author

	if command -v git &> /dev/null; then
		author="$(git config --get user.name) <$(git config --get user.email)>"
	fi
	[[ -d "${SOURCE_REPO}"/profiles/package.mask ]] ||
		mkdir "${SOURCE_REPO}"/profiles/package.mask
	[[ -f "${SOURCE_REPO}"/profiles/package.mask/${filename} ]] &&
		rm "${SOURCE_REPO}"/profiles/package.mask/${filename}

	touch "${SOURCE_REPO}"/profiles/package.mask/${filename}
	echo "# ${author} ($(date "+%Y-%m-%d"))" >> "${SOURCE_REPO}"/profiles/package.mask/${filename}
	echo "# $(pretty_setname ${set}-${version}) mask" >> "${SOURCE_REPO}"/profiles/package.mask/${filename}
	echo "# UNRELEASED" >> "${SOURCE_REPO}"/profiles/package.mask/${filename}
	echo "#" >> "${SOURCE_REPO}"/profiles/package.mask/${filename}
	get_package_list_from_set ${set} >> "${SOURCE_REPO}"/profiles/package.mask/${filename}
	sed -i -e "/^#/!s/^/~/" -e "/^#/!s/$/-${version}/" "${SOURCE_REPO}"/profiles/package.mask/${filename}
}

# @FUNCTION: mask_from_live_set
# @USAGE: <base set name> <target version> <filename>
# @DESCRIPTION:
# Takes sets/<base set name>-live, transforming it a profiles/package.mask/<filename>
# list of atoms with <target version>.
mask_from_live_set() {
	mask_from_set "${1}-live" "${2}" "${3}"
}

# @FUNCTION: pretty_setname
# @USAGE: <setname>
# @DESCRIPTION:
# Turns a basic set name into a pretty one.
#
# For example, "kde-frameworks-5.20" turns into "KDE Frameworks 5.20".
pretty_setname() {
	local set="${1}"
	echo ${set} | tr "-" " " | sed -e "s/\b\(.\)/\u\1/g" -e "s/kde/KDE/i"
}
