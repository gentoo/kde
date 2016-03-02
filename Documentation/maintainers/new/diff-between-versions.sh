#!/bin/bash

. $(dirname "$0")/lib.sh

: ${SOURCE_REPO:="$(realpath $(dirname $0)/../../../)"}
: ${TARGET_REPO:="$(pwd)"}

help() {
	echo Simple set-based ebuild differ.
	echo
	echo Given a set in the source repository, prints the diff between two versions
	echo of ebuilds in the target repository.
	echo
	echo Reads TARGET_REPO from your enviroment, defaulting to the current directory.
	echo
	echo Usage: diff-between-versions.sh SETNAME VERSION1 VERSION2
	echo Example: diff-between-versions.sh kde-frameworks-5.15 5.14.0 5.15.0
	exit 0
}


SETNAME="$1"
VERSION1="$2"
VERSION2="$3"

if [[ $1 == "--help" ]] ; then
	help
fi

if [[ -z "${SETNAME}" || -z "${VERSION1}" || -z "${VERSION2}" ]] ; then
	echo ERROR: Not enough arguments
	echo
	help
fi

packages=$(get_package_list_from_set ${SETNAME})

for cp in ${packages} ; do
	trap "echo Exited without finishing!; exit;" SIGINT SIGTERM

	target_dir="${TARGET_REPO}/${cp}"

	pushd "${TARGET_REPO}/${cp}" > /dev/null
	pn=$(basename $(pwd))
	diff -u "${pn}-${VERSION1}.ebuild" "${pn}-${VERSION2}.ebuild"

	popd > /dev/null
done
