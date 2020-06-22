#!/bin/bash

# Requires:
# app-portage/repoman
# Optional:
# dev-vcs/git
# app-portage/mgorny-dev-scripts

. $(dirname "$0")/lib.sh

: ${SOURCE_REPO:="$(realpath $(dirname $0)/../../../)"}
: ${TARGET_REPO:="$(pwd)"}

help() {
	echo Simple set-based ebuild copier.
	echo
	echo Given a set in the source repository, copies all ebuilds with the specified
	echo version into the target repository. Optionally, if target is a git repository,
	echo each ebuild will be committed as \"cat/pn: TARGETVERSION version bump\"
	echo
	echo Reads TARGET_REPO from your enviroment, defaulting to the current directory.
	echo
	echo Usage: copy-to-main-tree.sh SETNAME TARGETVERSION
	echo Example: copy-to-main-tree.sh kde-frameworks-5.72 5.72.0
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

if [[ -d "${TARGET_REPO}/.git" ]] && hash git 2>/dev/null && hash pkgcommit 2>/dev/null; then
	for cp in ${packages} ; do
		pushd "${TARGET_REPO}/${cp}" > /dev/null

		git add .
		pkgcommit -sS . -m "${TARGETVERSION} version bump"

		popd > /dev/null
	done
fi
