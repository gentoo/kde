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
	echo Simple tool to bump a KDE set.
	echo
	echo Given a set name, copies the live set to the new set version
	echo and updates the package versions appropriately.
	echo
	echo Reads PORTDIR from your enviroment, defaulting to the current directory.
	echo
	echo Usage: set-bump.sh SETNAME DESTINATIONVERSION
	echo Example: set-bump.sh kde-plasma 5.1
	exit 0
}


SETNAME="$1"
DESTINATIONVERSION="$2"

if [[ $1 == "--help" ]] ; then
	help
fi

if [[ -z "${SETNAME}" || -z "${DESTINATIONVERSION}" ]] ; then
	echo ERROR: Not enough arguments
	echo
	help
fi

pushd "${PORTDIR}/sets" > /dev/null

cp ${SETNAME}-live ${SETNAME}-${DESTINATIONVERSION}
sed -e "s/~/</" -e "s/9999/${DESTINATIONVERSION}.50:5/" -i ${SETNAME}-${DESTINATIONVERSION}

popd > /dev/null
