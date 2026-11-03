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
	echo "Example: gear-bump.sh 26.04.2"
	echo "Example: gear-bump.sh 26.04 26.03.90"
	exit 0
}

if [[ $1 == "--help" ]] ; then
	help
fi

if [[ -z "${1}" ]] ; then
	echo ERROR: Not enough arguments
	echo
	help
elif [[ -z "${2}" ]] ; then
	VERSION="${1}"
	MAINVERSION="$(main_version ${VERSION})"
else
	VERSION="${2}"
	MAINVERSION="${1}"
fi

kfv="kde-gear-${VERSION}"
kfmv="kde-gear-${MAINVERSION}"

pushd "${TARGET_REPO}" > /dev/null

if ! [[ -f sets/kde-gear-${MAINVERSION} ]]; then
	bump_set_from_live kde-gear ${MAINVERSION}
	create_keywords_files ${kfmv} kde-gear

	sed -i -e "/GEAR_RELEASES/s/ *)$/ ${MAINVERSION} )/" Documentation/maintainers/regenerate-files
	Documentation/maintainers/regenerate-files

	bump_packages_from_set kde-gear-${MAINVERSION} 9999 ${MAINVERSION}.49.9999
	commit_packages ${kfmv} "Add ${MAINVERSION} stable branch"
fi

mask_from_set kde-gear-${MAINVERSION} ${VERSION} ${kfv}
mark_unreleased gear ${VERSION}

bump_packages_from_set kde-gear-${MAINVERSION} ${MAINVERSION}.49.9999 ${VERSION}
commit_packages ${kfmv} "${VERSION} version bump"

popd > /dev/null
