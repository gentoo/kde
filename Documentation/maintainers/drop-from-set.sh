#!/bin/sh

# requires app-portage/portage-utils and app-portage/gentoolkit-dev

: ${PORTDIR:="$(pwd)"}

get_package_list_from_set() {

	local SET="${1}"

	for entry in $(grep -v ^[#@] "${PORTDIR}/sets/${SET}") ; do
		echo $(qatom ${entry} | cut -d " " -f 1-2 | tr " " "/")
	done

}

help() {
	echo Simple set-based version removed.
	echo
	echo Given a set file, removes all packages of a specified version.
	echo
	echo Reads PORTDIR from your environment, defaulting to the current directory.
	echo
	echo Usage: drop-from-set.sh SETNAME VERSION
	echo Example: drop-from-set.sh kde-plasma-5.0 5.0.1
	exit 0
}


SETNAME="$1"
VERSION="$2"

if [[ $1 == "--help" ]] ; then
	help
fi

if [[ -z "${SETNAME}" || -z "${VERSION}" ]] ; then
	echo ERROR: Not enough arguments
	echo
	help
fi

packages=$(get_package_list_from_set ${SETNAME})

for package in ${packages} ; do
	pushd "${PORTDIR}/${package}" > /dev/null

	pn=$(basename $(pwd))

	rm -f ${pn}-${VERSION}.ebuild
	rm -f ${pn}-${VERSION}-r*.ebuild

	repoman manifest

done
