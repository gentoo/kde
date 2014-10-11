# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# @ECLASS: kde5-functions.eclass
# @MAINTAINER:
# kde@gentoo.org
# @BLURB: Common ebuild functions for KDE 5 packages
# @DESCRIPTION:
# This eclass contains all functions shared by the different eclasses,
# for KDE 5 ebuilds.

if [[ -z ${_KDE5_FUNCTIONS_ECLASS} ]]; then
_KDE5_FUNCTIONS_ECLASS=1

inherit toolchain-funcs versionator

# @ECLASS-VARIABLE: EAPI
# @DESCRIPTION:
# Currently EAPI 5 is supported.
case ${EAPI} in
	5) ;;
	*) die "EAPI=${EAPI:-0} is not supported" ;;
esac

# @ECLASS-VARIABLE: FRAMEWORKS_MINIMAL
# @DESCRIPTION:
# Minimal Frameworks version to require for the package.
: ${FRAMEWORKS_MINIMAL:=5.3.0}

# @ECLASS-VARIABLE: KDEBASE
# @DESCRIPTION:
# This gets set to a non-zero value when a package is considered a kde or
# kdevelop ebuild.
if [[ ${CATEGORY} = kde-base ]]; then
	KDEBASE=kde-base
elif [[ ${CATEGORY} = kde-frameworks ]]; then
	KDEBASE=kde-frameworks
elif [[ ${KMNAME-${PN}} = kdevelop ]]; then
	KDEBASE=kdevelop
fi

debug-print "${ECLASS}: ${KDEBASE} ebuild recognized"

# @ECLASS-VARIABLE: KDE_SCM
# @DESCRIPTION:
# SCM to use if this is a live ebuild.
: ${KDE_SCM:=git}

case ${KDE_SCM} in
	svn|git) ;;
	*) die "KDE_SCM: ${KDE_SCM} is not supported" ;;
esac

# determine the build type
if [[ ${PV} = *9999* ]]; then
	KDE_BUILD_TYPE="live"
else
	KDE_BUILD_TYPE="release"
fi
export KDE_BUILD_TYPE

# @FUNCTION: _check_gcc_version
# @INTERNAL
# @DESCRIPTION:
# Determine if the current GCC version is acceptable, otherwise die.
_check_gcc_version() {
	if [[ ${MERGE_TYPE} != binary ]]; then
		local version=$(gcc-version)
		local major=${version%.*}
		local minor=${version#*.}

		[[ ${major} -lt 4 ]] || \
				( [[ ${major} -eq 4 && ${minor} -lt 8 ]] ) \
			&& die "Sorry, but gcc-4.8 or later is required for KDE 5."
	fi
}

# @FUNCTION: _add_kdecategory_dep
# @INTERNAL
# @DESCRIPTION:
# Implementation of add_kdebase_dep and add_frameworks_dep.
_add_kdecategory_dep() {
	debug-print-function ${FUNCNAME} "$@"

	local category=${1}
	local package=${2}
	local use=${3}
	local minversion=${4}
	local version

	if [[ -n ${minversion} ]]; then
		version=${minversion}
	# if building stable-live version depend just on the raw KDE version
	# to allow merging packages against more stable basic stuff
	elif [[ ${PV} == *.9999 ]]; then
		version=$(get_kde_version)
	else
		version=${PV}
	fi

	if [[ -n ${use} ]] ; then
		usedep="[${use}]"
	fi

	echo " >=${category}/${package}-${version}:5${usedep}"
}

# @FUNCTION: add_frameworks_dep
# @USAGE: <package> [USE flags] [minimum version]
# @DESCRIPTION:
# Create proper dependency for kde-frameworks/ dependencies.
# This takes 1 to 3 arguments. The first being the package name, the optional
# second is additional USE flags to append, and the optional third is the
# version to use instead of the automatic version (use sparingly).
# The output of this should be added directly to DEPEND/RDEPEND, and may be
# wrapped in a USE conditional (but not an || conditional without an extra set
# of parentheses).
add_frameworks_dep() {
	debug-print-function ${FUNCNAME} "$@"

	local version

	if [[ -n ${3} ]]; then
		version=${3}
	elif [[ ${CATEGORY} = kde-frameworks ]]; then
		version=${PV}
	elif [[ ${CATEGORY} = kde-base ]]; then
		case $(get_kde_version) in
			5.1) version=5.3.0 ;;
			*) version=${FRAMEWORKS_MINIMAL} ;;
		esac
	elif [[ -z "${version}" ]] ; then
		version=${FRAMEWORKS_MINIMAL}
	fi

	_add_kdecategory_dep kde-frameworks "${1}" "${2}" "${version}"
}

# @FUNCTION: add_kdebase_dep
# @USAGE: <package> [USE flags] [minimum version]
# @DESCRIPTION:
# Create proper dependency for kde-base/ dependencies.
# This takes 1 to 3 arguments. The first being the package name, the optional
# second is additional USE flags to append, and the optional third is the
# version to use instead of the automatic version (use sparingly).
# The output of this should be added directly to DEPEND/RDEPEND, and may be
# wrapped in a USE conditional (but not an || conditional without an extra set
# of parentheses).
add_kdebase_dep() {
	debug-print-function ${FUNCNAME} "$@"

	_add_kdecategory_dep kde-base "${1}" "${2}" "${3}"
}

# @FUNCTION: get_kde_version
# @DESCRIPTION:
# Translates an ebuild version into a major.minor KDE SC
# release version. If no version is specified, ${PV} is used.
get_kde_version() {
	local ver=${1:-${PV}}
	local major=$(get_major_version ${ver})
	local minor=$(get_version_component_range 2 ${ver})
	local micro=$(get_version_component_range 3 ${ver})
	if [[ ${ver} == 9999 ]]; then
		echo live
	else
		(( micro < 50 )) && echo ${major}.${minor} || echo ${major}.$((minor + 1))
	fi
}

# @FUNCTION: punt_bogus_deps
# @DESCRIPTION:
# Remove hard-coded upstream dependencies that are not correct.
punt_bogus_deps() {
	sed -e "/find_package(Qt5 /s/ Test//" -i CMakeLists.txt || die
}

fi
