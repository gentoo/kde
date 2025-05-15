#!/bin/bash
. "$(dirname "$0")/lib.sh"

: ${TARGET_REPO:="$(pwd)"}

help() {
	echo "Perform a version bump of KDE Plasma."
	echo
	echo "Based on a kde-plasma-<version> set, this script performs a full version bump"
	echo "of a new KDE Plasma."
	echo
	echo "In addition to the new ebuild being created, the following operations are performed:"
	echo
	echo "* Creation of package.mask entry"
	echo "* Eclass modification to mark as unreleased"
	echo "If necessary:"
	echo "* Creation of versioned set from kde-plasma-live"
	echo "* Generation of package.* files in Documentation"
	echo
	echo "Usage: plasma-bump.sh <version>"
	echo "Example: plasma-bump.sh 5.26.0"
	exit 0
}

if [[ $1 == "--help" ]] ; then
	help
fi

VERSION="${1}"

if [[ -z "${VERSION}" ]] ; then
	echo ERROR: Not enough arguments
	echo
	help
fi

major_version=$(echo ${VERSION} | cut -d "." -f 1-2)
kfv="kde-plasma-${VERSION}"
kfmv="kde-plasma-${major_version}"

pushd "${TARGET_REPO}" > /dev/null

if ! [[ -f sets/kde-plasma-${major_version} ]]; then
	bump_set_from_live kde-plasma ${major_version} # TODO: s/49.9999/50:5/
	create_keywords_files ${kfmv} kde-plasma

	sed -i -e "/PLASMA_RELEASES/s/ *)$/ ${major_version} )/" Documentation/maintainers/regenerate-files
	Documentation/maintainers/regenerate-files
fi

# only .0 version gets non public tarballs pre-release
if [[ ${VERSION} == *.0 ]]; then
	mask_from_set kde-plasma-${major_version} ${VERSION} ${kfv}
	mark_unreleased plasma ${VERSION}
fi

bump_packages_from_set kde-plasma-${major_version} ${major_version}.49.9999 ${VERSION}
commit_packages ${kfmv} "${VERSION} version bump"

popd > /dev/null
