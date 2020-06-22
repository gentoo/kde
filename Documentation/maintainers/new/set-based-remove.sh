#!/bin/sh

# Requires:
# app-portage/repoman
# Optional:
# dev-vcs/git
# app-portage/mgorny-dev-scripts
# dev-util/pkgcheck

. $(dirname "$0")/lib.sh

: ${TARGET_REPO:="$(pwd)"}

help() {
	echo Simple set-based version removed.
	echo
	echo Given a set file, removes all packages of a specified version.
	echo Optionally, if target is a git repository, each change will be
	echo committed as \"cat/pn: drop VERSION*\".
	echo
	echo Reads TARGET_REPO from your environment, defaulting to the current directory.
	echo
	echo Usage: set-based-remove.sh SETNAME VERSION
	echo Example: set-based-remove.sh kde-plasma-5.19 5.19.1
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

if [[ -d "${TARGET_REPO}/.git" ]] && hash git 2>/dev/null && hash pkgcommit 2>/dev/null; then
	for cp in ${packages} ; do
		pushd "${TARGET_REPO}/${cp}" > /dev/null

		git add .
		pkgcommit -sS . -m "drop ${VERSION}*"

		popd > /dev/null
	done

	if hash pkgcheck 2>/dev/null; then
		pushd "${TARGET_REPO}" > /dev/null
			pkgcheck scan --commits
		popd > /dev/null
	fi
fi
