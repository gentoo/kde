#!/bin/sh
. "$(dirname "$0")/lib.sh"

: ${TARGET_REPO:="$(pwd)"}

help() {
	echo "Perform a version bump of KDE Release Service."
	echo
	echo "Based on the kde-gear-live set, this script performs a full version bump"
	echo "of a new unreleased KDE Release Service."
	echo
	echo "In addition to the new ebuild being created, the following operations are performed:"
	echo
	echo "* Creation of package.mask entry"
	echo "* Eclass modification to mark as unreleased"
	echo "If necessary:"
	echo "* Creation of versioned set from kde-gear-live"
	echo "* Generation of package.* files in Documentation"
	echo
	echo "Usage: gear-bump.sh <version>"
	echo "Example: gear-bump.sh 22.08.2"
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
kfv="kde-gear-${VERSION}"
kfmv="kde-gear-${major_version}"

pushd "${TARGET_REPO}" > /dev/null

if ! [[ -f sets/kde-gear-${major_version} ]]; then
	bump_set_from_live kde-gear ${major_version}
	create_keywords_files ${kfmv} kde-gear

	sed -i -e "/GEAR_RELEASES/s/ *)$/ ${major_version} )/" Documentation/maintainers/regenerate-files
	Documentation/maintainers/regenerate-files

	bump_packages_from_set kde-gear-${major_version} 9999 ${major_version}.49.9999
	commit_packages ${kfmv} "Add ${major_version} stable branch"
fi

mask_from_set kde-gear-${major_version} ${VERSION} ${kfv}
mark_unreleased gear ${VERSION}

bump_packages_from_set kde-gear-${major_version} ${major_version}.49.9999 ${VERSION}
commit_packages ${kfmv} "${VERSION} version bump"

popd > /dev/null
