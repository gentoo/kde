#!/bin/sh

# Requires app-portage/repoman

. $(dirname "$0")/lib.sh

: ${TARGET_REPO:="$(pwd)"}

help() {
	echo Simple set-based version removed.
	echo
	echo Given a set file, removes all packages of a specified version.
	echo
	echo Reads TARGET_REPO from your environment, defaulting to the current directory.
	echo
	echo Usage: set-based-remove.sh SETNAME VERSION
	echo Example: set-based-remove.sh kde-plasma-5.0 5.0.1
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
	trap "echo Exited without finishing!; exit;" SIGINT SIGTERM
	pushd "${TARGET_REPO}/${package}" > /dev/null

	pn=$(basename $(pwd))

	rm -f ${pn}-${VERSION}.ebuild
	rm -f ${pn}-${VERSION}-r*.ebuild

	repoman manifest
	popd > /dev/null
done
