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
	echo "Usage: plasma-bump.sh [main-version] <bump-version>"
	echo "Example: plasma-bump.sh 6.6.0"
	echo "Example: plasma-bump.sh 6.6 6.5.90"
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
	MAINVERSION=$(echo ${VERSION} | cut -d "." -f 1-2)
else
	VERSION="${2}"
	MAINVERSION="${1}"
fi

kfv="kde-plasma-${VERSION}"
kfmv="kde-plasma-${MAINVERSION}"

pushd "${TARGET_REPO}" > /dev/null

if ! [[ -f sets/kde-plasma-${MAINVERSION} ]]; then
	bump_set_from_live kde-plasma ${MAINVERSION} # TODO: s/49.9999/50:5/
	create_keywords_files ${kfmv} kde-plasma

	sed -i -e "/PLASMA_RELEASES/s/ *)$/ ${MAINVERSION} )/" Documentation/maintainers/regenerate-files
	Documentation/maintainers/regenerate-files

	# initial stable branch bump
	bump_packages_from_set kde-plasma-${MAINVERSION} 9999 ${MAINVERSION}.49.9999
	commit_packages ${kfmv} "add ${MAINVERSION}.49.9999 stable branch"
else
	case ${VERSION} in
		*.0)
			# only .0 version gets non public tarballs pre-release
			mark_unreleased plasma ${VERSION} ;&
		*.9?)
			# beta versions are kept masked
			mask_from_set kde-plasma-${MAINVERSION} ${VERSION} ${kfv}
	esac

	bump_packages_from_set kde-plasma-${MAINVERSION} ${MAINVERSION}.49.9999 ${VERSION}
	commit_packages ${kfmv} "${VERSION} version bump"
fi

popd > /dev/null
