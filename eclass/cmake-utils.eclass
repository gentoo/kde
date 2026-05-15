# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: cmake-utils.eclass
# @MAINTAINER:
# kde@gentoo.org
# base-system@gentoo.org
# @SUPPORTED_EAPIS: 8 9
# @BLURB: General purpose functions for manipulating CMake files.
# @DESCRIPTION:
# A utility eclass providing functions to query and modify CMake files.
#
# This eclass does not export any phase functions. It can be inherited safely.

case ${EAPI} in
	8|9) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ -z ${_CMAKE_UTILS_ECLASS} ]]; then
_CMAKE_UTILS_ECLASS=1

# @ECLASS_VARIABLE: CMAKE_ECM_MODE
# @DEFAULT_UNSET
# @DESCRIPTION:
# Default value is "auto", which means _cmake_modify-cmakelists will make an
# effort to detect find_package(ECM) in CMakeLists.txt.  If set to true, make
# extra checks and add common config settings related to ECM (KDE Extra CMake
# Modules).  If set to false, do nothing.
: "${CMAKE_ECM_MODE:=auto}"

# @ECLASS_VARIABLE: CMAKE_QA_COMPAT_SKIP
# @DEFAULT_UNSET
# @DESCRIPTION:
# If set, skip detection of CMakeLists.txt unsupported in CMake 4 in case of
# false positives (e.g. unused outdated bundled libs).

# @ECLASS_VARIABLE: CMAKE_POLICY_VERSION_MINIMUM
# @DEFAULT_UNSET
# @DESCRIPTION:
# If set, this value should be passed to the CMake variable of the same name,
# as determined by cmake_minreqver_qainfo().

case ${CMAKE_ECM_MODE} in
	auto|true|false) ;;
	*)
		eerror "Unknown value for \${CMAKE_ECM_MODE}"
		die "Value ${CMAKE_ECM_MODE} is not supported"
		;;
esac

# @FUNCTION: cmake_comment_add_subdirectory
# @USAGE: [-f <filename or directory>] <subdirectory> [<subdirectories>]
# @DESCRIPTION:
# Comment out one or more add_subdirectory calls with #DONOTBUILD in
# a) a given file path (error out on nonexisting path)
# b) a CMakeLists.txt file inside a given directory (ewarn if not found)
# c) CMakeLists.txt in current directory (do nothing if not found).
cmake_comment_add_subdirectory() {
	local d filename="CMakeLists.txt"
	if [[ $# -lt 1 ]]; then
		die "${FUNCNAME[0]} must be passed at least one subdirectory name to comment"
	fi
	case ${1} in
		-f)
			if [[ $# -ge 3 ]]; then
				filename="${2}"
				if [[ -d ${filename} ]]; then
					filename+="/CMakeLists.txt"
					if [[ ! -e ${filename} ]]; then
						ewarn "You've given me nothing to work with in ${filename}!"
						return
					fi
				elif [[ ! -e ${filename} ]]; then
					die "${FUNCNAME}: called on non-existing ${filename}"
				fi
			else
				die "${FUNCNAME[0]}: bad number of arguments: -f <filename or directory> <subdirectory> expected"
			fi
			shift 2
			;;
		*)
			[[ -e ${filename} ]] || return
			;;
	esac

	for d in "$@"; do
		d=${d//\//\\/}
		sed -e "/add_subdirectory[[:space:]]*([[:space:]]*${d}\([[:space:]][a-Z_ ]*\|[[:space:]]*\))/I s/^/#DONOTBUILD /" \
			-i ${filename} || die "failed to comment add_subdirectory(${d})"
	done
}

# @FUNCTION: cmake_use_find_package
# @USAGE: <USE flag> <package name>
# @DESCRIPTION:
# Based on use_enable. See ebuild(5).
#
# `cmake_use_find_package foo LibFoo` echoes -DCMAKE_DISABLE_FIND_PACKAGE_LibFoo=OFF
# if foo is enabled and -DCMAKE_DISABLE_FIND_PACKAGE_LibFoo=ON if it is disabled.
# This can be used to make find_package optional.
cmake_use_find_package() {
	debug-print-function ${FUNCNAME} "$@"

	if [[ "$#" != 2 || -z $1 ]] ; then
		die "Usage: cmake_use_find_package <USE flag> <package name>"
	fi

	echo "-DCMAKE_DISABLE_FIND_PACKAGE_$2=$(use $1 && echo OFF || echo ON)"
}

# @FUNCTION: cmake_minreqver_qainfo
# @DESCRIPTION:
# QA Notice and file listings for any CMake file not meeting various minimum
# standards for cmake_minimum_required.  May be called from prepare or install
# phase, adjusts QA notice accordingly (build or installed files warning).
cmake_minreqver_qainfo() {
	# Arrays containing <file>:<version> tuples for any CMake file with
	# cmake_minimum_required version lower than defined.
	local minreqver305=() # -lt 3.5  (CMake-4 error)
	local minreqver310=() # -lt 3.10 (CMake-4 warning)
	local minreqver316=() # -lt 3.16 (ECM-5.100 warning)

	local contextdir
	# Flag unsupported minimum CMake version unless CMAKE_QA_COMPAT_SKIP is set
	cmake_chk_minreqver() {
		debug-print-function ${FUNCNAME} "$@"
		if [[ $# -ne 1 ]]; then
			die "${FUNCNAME[0]} must be passed exactly one argument"
		fi
		if [[ ${CMAKE_QA_COMPAT_SKIP} ]]; then
			return
		fi
		local file="$1" ver

		if [[ ${CMAKE_ECM_MODE} == auto ]] && grep -Eq "\s*find_package\s*\(\s*ECM " "${file}"; then
			CMAKE_ECM_MODE=true
		fi
		ver=$(sed -ne "/^\s*cmake_minimum_required/I{s/.*\(\.\.\.*\|\s\)\([0-9][0-9.]*\)\([)]\|\s\).*$/\2/p;q}" \
			"${1}" 2>/dev/null \
		)
		if [[ -n "${ver}" ]]; then
			# we don't want duplicates that were already flagged
			if ver_test "${ver}" -lt "3.5"; then
				minreqver305+=( "${file#"${contextdir}/"}":"${ver}" )
			elif ver_test "${ver}" -lt "3.10"; then
				minreqver310+=( "${file#"${contextdir}/"}":"${ver}" )
			elif ver_test "${ver}" -lt "3.16"; then
				minreqver316+=( "${file#"${contextdir}/"}":"${ver}" )
			fi
		fi
	}

	case ${EBUILD_PHASE} in
		prepare)
			contextdir="${S}"
			cmake_recurse_files "${contextdir}" "CMakeLists.txt" cmake_chk_minreqver
			;;
		install)
			contextdir="${D}"
			cmake_recurse_files "${contextdir}" "*.cmake" cmake_chk_minreqver
			;;
		*)
			die "${FUNCNAME[0]} called from unsupported phase function"
			;;
	esac

	local warnlvl
	[[ ${#minreqver305[@]} != 0 ]] && warnlvl=305
	[[ ${#minreqver310[@]} != 0 ]] || [[ -n ${warnlvl} ]] && warnlvl=310
	[[ ${CMAKE_ECM_MODE} == true ]] &&
		{ [[ ${#minreqver316[@]} != 0 ]] || [[ -n ${warnlvl} ]]; } && warnlvl=316

	local weak_qaw="QA Notice: "
	minreqver_qanotice() {
		bug() {
			case ${1} in
				305) echo "951350" ;;
				310) echo "964405" ;;
				316) echo "964407" ;;
			esac
		}
		minreqver_qanotice_prepare() {
			case ${1} in
				305)
					eqawarn "${weak_qaw}Compatibility with CMake < 3.5 has been removed from CMake 4,"
					eqawarn "${CATEGORY}/${PN} will fail to build w/o a fix."
					;;
				310) eqawarn "${weak_qaw}Compatibility with CMake < 3.10 will be removed in a future release." ;;
				316) eqawarn "${weak_qaw}Compatibility w/ CMake < 3.16 will be removed in future ECM release." ;;
			esac
		}
		minreqver_qanotice_install() {
			case ${1} in
				305)
					eqawarn "${weak_qaw}Package installs CMake module(s) incompatible with CMake 4,"
					eqawarn "breaking any packages relying on it."
					;;
				31[06])
					eqawarn "${weak_qaw}Package installs CMake module(s) w/ <${1/3/3.} minimum version that will"
					eqawarn "be unsupported by future releases and is going to break any packages relying on it."
					;;
			esac
		}
		minreqver_qanotice_${EBUILD_PHASE} ${1}
		eqawarn "See also tracker bug #$(bug ${1}); check existing or file a new bug for this package."
		case ${1} in
			305)	eqawarn "Please also take it upstream." ;;
			31[06])	eqawarn "If not fixed in upstream's code repository, we should make sure they are aware." ;;
		esac
		eqawarn
		weak_qaw="" # weak notice: no "QA Notice" starting with second call
	}

	local info
	# <eqawarn msg> <_CMAKE_MINREQVER_* array>
	minreqver_listing() {
		[[ ${#@} -gt 1 ]] || return
		eqawarn "${1}"
		shift
		for info in "${@}"; do
			eqawarn "  ${info}";
		done
		eqawarn
	}

	# CMake 4-caused error is highest priority and must always be shown
	if [[ ${#minreqver305[@]} != 0 ]]; then
		minreqver_qanotice 305
		minreqver_listing "The following files are causing errors:" ${minreqver305[*]}
	fi
	# for warnings, we only want the latest relevant one, but list all flagged files
	if [[ ${warnlvl} -ge 310 ]]; then
		minreqver_qanotice ${warnlvl}
		minreqver_listing "The following files are causing warnings:" ${minreqver310[*]}
		[[ ${warnlvl} == 316 ]] &&
			minreqver_listing "The following files are causing warnings:" ${minreqver316[*]}
	fi
	if [[ ${warnlvl} ]]; then
		if [[ ${EBUILD_PHASE} == prepare && ${#minreqver305[@]} != 0 ]] && has_version -b ">=dev-build/cmake-4"; then
			if has cmake ${INHERITED}; then
				eqawarn "CMake 4 detected; building with -DCMAKE_POLICY_VERSION_MINIMUM=3.5"
			else
				eqawarn "CMake 4 detected; ebuild should pass -DCMAKE_POLICY_VERSION_MINIMUM=3.5"
			fi
			eqawarn "This is merely a workaround to avoid CMake Error and *not* a permanent fix;"
			eqawarn "there may be new build or runtime bugs as a result."
			eqawarn
			CMAKE_POLICY_VERSION_MINIMUM=3.5
		fi
		eqawarn "An upstreamable patch should take any resulting CMake policy changes"
		eqawarn "into account. See also:"
		eqawarn "  https://cmake.org/cmake/help/latest/manual/cmake-policies.7.html"
	fi
}

# @FUNCTION: cmake_recurse_files
# @USAGE: <rootdir> <filename> <run command>
# @DESCRIPTION:
# Recurse over all <filename(s) (case-insensitive)> below <rootdir> and
# call a given <run command> with <filename> as argument.
cmake_recurse_files() {
	if [[ $# -lt 3 ]]; then
		die "${FUNCNAME[0]} must be passed at least three arguments"
	fi
	local file rootdir="${1}" iname="${2}" runcmd="${3}"

	[[ -e ${rootdir} ]] || die "${FUNCNAME[0]}: Nonexistent path: ${rootdir}"

	while read -d '' -r file ; do
		"${runcmd}" "${file}"
	done < <(find "${rootdir}" -type f -iname "${iname}" -print0 || die)
}

# @FUNCTION: cmake_run_in
# @USAGE: <working dir> <run command>
# @DESCRIPTION:
# Set the desired working dir for a function or command.
cmake_run_in() {
	if [[ -z ${2} ]]; then
		die "${FUNCNAME[0]} must be passed at least two arguments"
	fi

	[[ -e ${1} ]] || die "${FUNCNAME[0]}: Nonexistent path: ${1}"

	pushd ${1} > /dev/null || die
		"${@:2}"
	popd > /dev/null || die
}

fi
