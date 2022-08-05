#!/bin/bash

# Requires:
# app-portage/portage-utils
# app-portage/gentoolkit-dev
# dev-util/pkgdev
# Optional:
# dev-vcs/git
# dev-util/pkgcheck

: ${PORTDIR:="$(pwd)"}

get_package_list_from_set() {
	local set="${1}"

	for entry in $(grep -v ^[#@] "${PORTDIR}/sets/${set}") ; do
		echo $(qatom ${entry} | cut -d " " -f 1-2 | tr " " "/")
	done

	for entry in $(grep ^@ "${PORTDIR}/sets/${set}") ; do
		get_package_list_from_set ${entry/@/}
	done
}

get_main_tree_keyword() {
	local portdir="$(portageq get_repo_path / gentoo)"
	local cp="${1}"
	if [[ -e ${portdir}/${cp} ]] ; then
		echo $(sed -ne 's/^\s*KEYWORDS="\(.*\)"/\1/p' "$(ls ${portdir}/${cp}/*.ebuild | sort | tail -n 1)")
	else
		echo "~amd64 ~x86"
	fi
}

help() {
	echo Simple set-based version bumper.
	echo
	echo Given a set file, bumps all packages in the given set given source
	echo and destination versions. Optionally, if destination is a git repository,
	echo each ebuild will be committed as \"cat/pn: DESTINATIONVERSION version bump\".
	echo Designed for workflows where ebuilds are bumped from up-to-date live versions.
	echo
	echo Reads PORTDIR from your enviroment, defaulting to the current directory.
	echo
	echo Usage: bump-from-set.sh SETNAME SOURCEVERSION DESTINATIONVERSION
	echo Example: bump-from-set.sh kde-plasma-5.19 5.19.49.9999 5.19.2
	exit 0
}


SETNAME="$1"
SOURCEVERSION="$2"
DESTINATIONVERSION="$3"

if [[ $1 == "--help" ]] ; then
	help
fi

if [[ -z "${SETNAME}" || -z "${SOURCEVERSION}" || -z "${DESTINATIONVERSION}" ]] ; then
	echo ERROR: Not enough arguments
	echo
	help
fi

packages=$(get_package_list_from_set ${SETNAME})

for cp in ${packages} ; do
	pushd "${PORTDIR}/${cp}" > /dev/null

	pn=$(basename $(pwd))
	source=${pn}-${SOURCEVERSION}.ebuild
	destination=${pn}-${DESTINATIONVERSION}.ebuild

	cp ${source} ${destination}
	ekeyword ^all ${destination} > /dev/null

	if [[ ${destination} != *9999* ]] ; then
		ekeyword $(get_main_tree_keyword ${cp}) ${destination} > /dev/null
		ekeyword ~all ${destination} > /dev/null
	fi

	pkgdev manifest

	popd > /dev/null
done

if [[ -d "${PORTDIR}/.git" ]] && hash git 2>/dev/null && hash pkgdev 2>/dev/null; then
	for cp in ${packages} ; do
		pushd "${PORTDIR}/${cp}" > /dev/null

		git add .
		pkgdev commit . -m "${DESTINATIONVERSION} version bump" -s false

		popd > /dev/null
	done

	if hash pkgcheck 2>/dev/null; then
		pushd "${PORTDIR}" > /dev/null
			pkgcheck scan --commits
		popd > /dev/null
	fi
fi
