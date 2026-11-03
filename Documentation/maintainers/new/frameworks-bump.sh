#!/bin/bash
. "$(dirname "$0")/lib.sh"

: ${TARGET_REPO:="$(pwd)"}

help() {
	echo "Perform a version bump of KDE Frameworks 6."
	echo
	echo "Based on the kde-frameworks-live sets, this script performs a full version bump"
	echo "of a new unreleased KDE Frameworks."
	echo
	echo "In addition to the new ebuild being created, the following operations are performed:"
	echo
	echo "* Creation of versioned set"
	echo "* Creation of package.mask entry"
	echo "* Eclass modification to mark as unreleased"
	echo "* Generation of package.* files in Documentation"
	echo
	echo "Usage: frameworks-bump.sh <version>"
	echo "Example: frameworks-bump.sh 6.32.0"
	exit 0
}

if [[ ${1} == "--help" ]] ; then
	help
fi

VERSION="${1}"

if [[ -z "${VERSION}" ]] ; then
	echo "ERROR: Not enough arguments"
	echo
	help
fi

major_minor_version=$(echo ${VERSION} | cut -d "." -f 1-2)
kfmv="kde-frameworks-${major_minor_version}"
setname="kde-frameworks"
base_version=9999

pushd "${TARGET_REPO}" > /dev/null

bump_set_from_live ${setname} ${major_minor_version}
mask_from_live_set ${setname} ${VERSION} kde-frameworks-${VERSION}
mark_unreleased frameworks ${VERSION}
create_keywords_files ${kfmv} ${setname}

sed -e "/KF6_RELEASES/s/ *)$/ ${major_minor_version} )/" \
	-i "${SOURCE_REPO}"/Documentation/maintainers/regenerate-files
Documentation/maintainers/regenerate-files

bump_packages_from_set ${setname}-live ${base_version} ${VERSION}
commit_packages ${kfmv} "${VERSION} version bump"

popd > /dev/null
