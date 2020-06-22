#!/bin/sh

# Requires:
# app-portage/portage-utils
# app-portage/gentoolkit-dev
# app-portage/repoman

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
		echo $(sed -ne 's/^KEYWORDS="\(.*\)"/\1/p' "$(ls ${portdir}/${cp}/*.ebuild | sort | tail -n 1)")
	else
		echo "~amd64 ~x86"
	fi
}

help() {
	echo Simple set-based version bumper.
	echo
	echo Given a set file, bumps all packages in the given set given source
	echo and destination versions. Designed for workflows where ebuilds are
	echo bumped from up-to-date live versions.
	echo
	echo Reads PORTDIR from your enviroment, defaulting to the current directory.
	echo
	echo Usage: bump-from-set.sh SETNAME SOURCEVERSION DESTINATIONVERSION
	echo Example: bump-from-set.sh kde-plasma-5.7 5.7.49.9999 5.7.1
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

	repoman manifest

	popd > /dev/null
done
