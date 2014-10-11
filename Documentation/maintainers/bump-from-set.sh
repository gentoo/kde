#!/bin/sh

# requires app-portage/portage-utils and app-portage/gentoolkit-dev

: ${KEYWORDS:="~amd64"}
: ${PORTDIR:="$(pwd)"}

get_package_list_from_set() {

	local SET="${1}"

	for entry in $(grep -v ^[#@] "${PORTDIR}/sets/${SET}") ; do
		echo $(qatom ${entry} | cut -d " " -f 1-2 | tr " " "/")
	done

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
	echo Reads KEYWORDS for the new ebuild from your environment, defaulting to ~amd64.
	echo
	echo Usage: bump-from-set.sh SETNAME SOURCEVERSION DESTINATIONVERSION
	echo Example: bump-from-set.sh kde-plasma-5.0 5.0.9999 5.0.1
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

for package in ${packages} ; do
	pushd "${PORTDIR}/${package}" > /dev/null

	pn=$(basename $(pwd))
	source=${pn}-${SOURCEVERSION}.ebuild
	destination=${pn}-${DESTINATIONVERSION}.ebuild

	cp ${source} ${destination}
	ekeyword ^all ${destination} > /dev/null

	if [[ ${destination} != *9999* ]] ; then
		ekeyword ${KEYWORDS} ${destination} > /dev/null
	fi

	repoman manifest

	popd > /dev/null
done
