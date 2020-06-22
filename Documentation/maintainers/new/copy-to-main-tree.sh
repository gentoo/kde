#!/bin/bash

# Requires app-portage/repoman

. $(dirname "$0")/lib.sh

: ${SOURCE_REPO:="$(realpath $(dirname $0)/../../../)"}
: ${TARGET_REPO:="$(pwd)"}

help() {
	echo Simple set-based ebuild copier.
	echo
	echo Given a set in the source repository, copies all ebuilds with the specified
	echo version into the target repository.
	echo
	echo Reads TARGET_REPO from your enviroment, defaulting to the current directory.
	echo
	echo Usage: copy-to-main-tree.sh SETNAME TARGETVERSION
	echo Example: copy-to-main-tree.sh kde-frameworks-5.15 5.15.0
	exit 0
}


SETNAME="$1"
TARGETVERSION="$2"

if [[ $1 == "--help" ]] ; then
	help
fi

if [[ -z "${SETNAME}" || -z "${TARGETVERSION}" ]] ; then
	echo ERROR: Not enough arguments
	echo
	help
fi

packages=$(get_package_list_from_set ${SETNAME})

for cp in ${packages} ; do
	trap "echo Exited without finishing!; exit;" SIGINT SIGTERM

	target_dir="${TARGET_REPO}/${cp}"

	if [[ ! -d "${target_dir}" ]] ; then
		mkdir "${target_dir}"
	fi

	pushd "${target_dir}" > /dev/null

	pn=$(basename $(pwd))
	ebuild="${pn}-${TARGETVERSION}.ebuild"

	cp "${SOURCE_REPO}/${cp}/${ebuild}" .
	repoman manifest

	popd > /dev/null

done
