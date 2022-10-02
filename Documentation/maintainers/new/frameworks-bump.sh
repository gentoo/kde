#!/bin/bash
. "$(dirname "$0")/lib.sh"

: ${TARGET_REPO:="$(pwd)"}

help() {
	echo "Perform a version bump of KDE Frameworks."
	echo
	echo "Based on the kde-frameworks-live set, this script performs a full version bump"
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
	echo "Example: frameworks-bump.sh 5.30"
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
kfv="kde-frameworks-${VERSION}"
kfmv="kde-frameworks-${major_version}"

pushd "${TARGET_REPO}" > /dev/null

bump_set_from_live kde-frameworks ${major_version}
mask_from_live_set kde-frameworks ${VERSION} ${kfv}
mark_unreleased frameworks ${VERSION}
create_keywords_files ${kfmv}

sed -i -e "/KF_RELEASES/s/\"$/ ${major_version}\"/" Documentation/maintainers/regenerate-files
Documentation/maintainers/regenerate-files

bump_packages_from_set kde-frameworks-live 9999 ${VERSION}
commit_packages ${kfmv} "${VERSION} version bump"

popd > /dev/null
