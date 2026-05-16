# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: cmake.eclass
# @MAINTAINER:
# kde@gentoo.org
# base-system@gentoo.org
# @AUTHOR:
# Tomáš Chvátal <scarabeus@gentoo.org>
# Maciej Mrozowski <reavertm@gentoo.org>
# (undisclosed contributors)
# Original author: Zephyrus (zephyrus@mirach.it)
# @SUPPORTED_EAPIS: 8
# @PROVIDES: cmake-utils ninja-utils
# @BLURB: common ebuild functions for cmake-based packages
# @DESCRIPTION:
# The cmake eclass makes creating ebuilds for cmake-based packages much easier.
# It provides all inherited features (DOCS, HTML_DOCS, PATCHES) along with
# out-of-source builds (default) and in-source builds.

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ -z ${_CMAKE_ECLASS} ]]; then
_CMAKE_ECLASS=1

inherit cmake-utils flag-o-matic multiprocessing ninja-utils toolchain-funcs xdg-utils

# @ECLASS_VARIABLE: BUILD_DIR
# @DEFAULT_UNSET
# @DESCRIPTION:
# Build directory where all cmake processed files should be generated.
# For in-source build it's fixed to ${CMAKE_USE_DIR}.
# For out-of-source build it can be overridden, by default it uses
# ${CMAKE_USE_DIR}_build (set inside _cmake_check_build_dir).

# @ECLASS_VARIABLE: CMAKE_BINARY
# @DESCRIPTION:
# Eclass can use different cmake binary than the one provided in by system.
: "${CMAKE_BINARY:=cmake}"

# @ECLASS_VARIABLE: CMAKE_BUILD_TYPE
# @DESCRIPTION:
# Set to override default CMAKE_BUILD_TYPE. Only useful for packages
# known to make use of "if (CMAKE_BUILD_TYPE MATCHES xxx)".
# If about to be set - needs to be set before invoking cmake_src_configure.
#
# The default is RelWithDebInfo as that is least likely to append undesirable
# flags. However, you may still need to sed CMake files or choose a different
# build type to achieve desirable results.
: "${CMAKE_BUILD_TYPE:=RelWithDebInfo}"

# @ECLASS_VARIABLE: CMAKE_IN_SOURCE_BUILD
# @DEFAULT_UNSET
# @DESCRIPTION:
# Set to enable in-source build.

# @ECLASS_VARIABLE: CMAKE_MAKEFILE_GENERATOR
# @PRE_INHERIT
# @DEFAULT_UNSET
# @DESCRIPTION:
# Specify a makefile generator to be used by cmake.
# At this point only "emake" and "ninja" are supported.
# The default is set to "ninja".
: "${CMAKE_MAKEFILE_GENERATOR:=ninja}"

# @ECLASS_VARIABLE: CMAKE_REMOVE_MODULES_LIST
# @PRE_INHERIT
# @DEFAULT_UNSET
# @DESCRIPTION:
# Array of .cmake modules to be removed in ${CMAKE_USE_DIR} during
# src_prepare, in order to force packages to use the system version.
# By default, contains "FindBLAS" and "FindLAPACK".
# Set to empty to disable removing modules entirely.
if [[ ${CMAKE_REMOVE_MODULES_LIST} ]]; then
	[[ ${CMAKE_REMOVE_MODULES_LIST@a} == *a* ]] ||
		die "CMAKE_REMOVE_MODULES_LIST must be an array"
fi

# @ECLASS_VARIABLE: CMAKE_USE_DIR
# @DESCRIPTION:
# Sets the directory where we are working with cmake, for example when
# application uses autotools and only one plugin needs to be done by cmake.
# By default it uses current working directory.

# @ECLASS_VARIABLE: CMAKE_VERBOSE
# @USER_VARIABLE
# @DESCRIPTION:
# Set to OFF to disable verbose messages during compilation
: "${CMAKE_VERBOSE:=ON}"

# @ECLASS_VARIABLE: CMAKE_WARN_UNUSED_CLI
# @DESCRIPTION:
# Warn about variables that are declared on the command line
# but not used. Might give false-positives.
# "no" to disable or anything else to enable.
# The default is set to "yes" (enabled).
: "${CMAKE_WARN_UNUSED_CLI:=yes}"

# @ECLASS_VARIABLE: CMAKE_EXTRA_CACHE_FILE
# @USER_VARIABLE
# @DEFAULT_UNSET
# @DESCRIPTION:
# Specifies an extra cache file to pass to cmake. This is the analog of EXTRA_ECONF
# for econf and is needed to pass TRY_RUN results when cross-compiling.
# Should be set by user in a per-package basis in /etc/portage/package.env.

# @ECLASS_VARIABLE: CMAKE_QA_SRC_DIR_READONLY
# @USER_VARIABLE
# @DEFAULT_UNSET
# @DESCRIPTION:
# After running cmake_src_prepare, sets ${CMAKE_USE_DIR} to read-only.
# This is a user flag and should under _no circumstances_ be set in the
# ebuild. Helps in improving QA of build systems that write to source tree.

# @ECLASS_VARIABLE: CMAKE_SKIP_TESTS
# @DEFAULT_UNSET
# @DESCRIPTION:
# Array of tests that should be skipped when running CTest.

case ${CMAKE_BUILD_TYPE} in
	Gentoo)
		ewarn "\${CMAKE_BUILD_TYPE} \"Gentoo\" is a no-op. Default is RelWithDebInfo."
		;;
	*) ;;
esac

case ${CMAKE_MAKEFILE_GENERATOR} in
	emake)
		BDEPEND="dev-build/make"
		;;
	ninja)
		BDEPEND="${NINJA_DEPEND}"
		;;
	*)
		eerror "Unknown value for \${CMAKE_MAKEFILE_GENERATOR}"
		die "Value ${CMAKE_MAKEFILE_GENERATOR} is not supported"
		;;
esac

if [[ ${PN} != cmake ]]; then
	BDEPEND+=" >=dev-build/cmake-3.31.9-r1"
fi

# @FUNCTION: _cmake_check_build_dir
# @INTERNAL
# @DESCRIPTION:
# Determine using IN or OUT source build
_cmake_check_build_dir() {
	# Since EAPI-8 we use current working directory, bug #704524
	: "${CMAKE_USE_DIR:=${PWD}}"
	if [[ -n ${CMAKE_IN_SOURCE_BUILD} ]]; then
		# we build in source dir
		BUILD_DIR="${CMAKE_USE_DIR}"
	else
		: "${BUILD_DIR:=${CMAKE_USE_DIR}_build}"

		# Avoid creating ${WORKDIR}_build (which is above WORKDIR).
		# TODO: For EAPI > 8, we should ban S=WORKDIR for CMake.
		# See bug #889420.
		if [[ ${S} == "${WORKDIR}" && ${BUILD_DIR} == "${WORKDIR}_build" ]] ; then
			eqawarn "QA Notice: S=WORKDIR is deprecated for cmake.eclass."
			eqawarn "Please relocate the sources in src_unpack."
			BUILD_DIR="${WORKDIR}"/${P}_build
		fi
	fi

	einfo "Source directory (CMAKE_USE_DIR): \"${CMAKE_USE_DIR}\""
	einfo "Build directory  (BUILD_DIR):     \"${BUILD_DIR}\""

	mkdir -p "${BUILD_DIR}" || die
}

# @FUNCTION: _cmake_modify-per-cmakelists
# @INTERNAL
# @DESCRIPTION:
# Comment out all set (<some_should_be_user_defined_variable> value)
# In EAPI-8, calls cmake_prepare-per-cmakelists().
_cmake_modify-per-cmakelists() {
	debug-print-function ${FUNCNAME} "$@"
	local file="$1"

	sed \
		-e '/^[[:space:]]*set[[:space:]]*([[:space:]]*CMAKE_BUILD_TYPE\([[:space:]].*)\|)\)/I{s/^/#_cmake_modify_IGNORE /g}' \
		-e '/^[[:space:]]*set[[:space:]]*([[:space:]]*CMAKE_\(COLOR_MAKEFILE\|INSTALL_PREFIX\|VERBOSE_MAKEFILE\)[[:space:]].*)/I{s/^/#_cmake_modify_IGNORE /g}' \
		-i "${file}" || die "failed to disable hardcoded settings"
	readarray -t mod_lines < <(grep -se "^#_cmake_modify_IGNORE" "${file}")
	if [[ ${#mod_lines[*]} -gt 0 ]]; then
		einfo "Hardcoded definition(s) removed in ${file/${CMAKE_USE_DIR%\/}\//}:"
		local mod_line
		for mod_line in "${mod_lines[@]}"; do
			einfo "${mod_line:22:99}"
		done
	fi

	if [[ ${EAPI} == 8 ]]; then
		cmake_prepare-per-cmakelists ${file}
	fi
}

# @FUNCTION: cmake_prepare-per-cmakelists
# @USAGE: <path-to-current-CMakeLists.txt>
# @DESCRIPTION:
# Override this to be provided with a hook into the cmake_src_prepare loop
# over all CMakeLists.txt below CMAKE_USE_DIR. Will be called from inside
# that loop with <path-to-current-CMakeLists.txt> as single argument.
# Used for recursive CMakeLists.txt detections and modifications.
cmake_prepare-per-cmakelists() {
	return
}

# @FUNCTION: _cmake_modify-cmakelists
# @INTERNAL
# @DESCRIPTION:
# Internal function for modifying hardcoded definitions.
# Removes dangerous definitions that override Gentoo settings.
_cmake_modify-cmakelists() {
	debug-print-function ${FUNCNAME} "$@"

	# Only edit the files once
	grep -qs "<<< Gentoo configuration >>>" "${CMAKE_USE_DIR}"/CMakeLists.txt && return 0

	cmake_recurse_files "${CMAKE_USE_DIR}" "CMakeLists.txt" _cmake_modify-per-cmakelists

	# NOTE Append some useful summary here
	cat >> "${CMAKE_USE_DIR}"/CMakeLists.txt <<- _EOF_ || die

		message(STATUS "<<< Gentoo configuration >>>
		Build type      \${CMAKE_BUILD_TYPE}
		Install path    \${CMAKE_INSTALL_PREFIX}
		Compiler flags:
		C               \${CMAKE_C_FLAGS}
		C++             \${CMAKE_CXX_FLAGS}
		Linker flags:
		Executable      \${CMAKE_EXE_LINKER_FLAGS}
		Module          \${CMAKE_MODULE_LINKER_FLAGS}
		Shared          \${CMAKE_SHARED_LINKER_FLAGS}\n")
	_EOF_
}

# @FUNCTION: cmake_prepare
# @DESCRIPTION:
# Check existence of and sanitise CMake files, then make ${CMAKE_USE_DIR}
# read-only.  *MUST* be run or cmake_src_configure will fail.
cmake_prepare() {
	debug-print-function ${FUNCNAME} "$@"

	_cmake_check_build_dir

	# Check if CMakeLists.txt exists and if not then die
	if [[ ! -e ${CMAKE_USE_DIR}/CMakeLists.txt ]] ; then
		eerror "Unable to locate CMakeLists.txt under:"
		eerror "\"${CMAKE_USE_DIR}/CMakeLists.txt\""
		eerror "Consider not inheriting the cmake eclass."
		die "FATAL: Unable to find CMakeLists.txt"
	fi

	if [[ ${CMAKE_REMOVE_MODULES_LIST@a} != *a* ]]; then
		if has_version -b "<dev-build/cmake-4.2.1"; then
			CMAKE_REMOVE_MODULES_LIST=( FindBLAS FindLAPACK )
		fi
	fi
	local modules_list=( "${CMAKE_REMOVE_MODULES_LIST[@]}" )

	local name
	for name in "${modules_list[@]}" ; do
		find -name "${name}.cmake" -exec rm -v {} + || die
	done

	_cmake_modify-cmakelists # remove dangerous things
	cmake_minreqver_qainfo

	# Make ${CMAKE_USE_DIR} read-only in order to detect broken build systems
	if [[ ${CMAKE_QA_SRC_DIR_READONLY} && ! ${CMAKE_IN_SOURCE_BUILD} ]]; then
		chmod -R a-w "${CMAKE_USE_DIR}"
	fi

	_CMAKE_PREPARE_HAS_RUN=1
}

# @FUNCTION: cmake_src_prepare
# @DESCRIPTION:
# Apply ebuild and user patches via default_src_prepare.  In case of
# conflict with another eclass' src_prepare phase, use cmake_prepare
# instead.
cmake_src_prepare() {
	debug-print-function ${FUNCNAME} "$@"

	default_src_prepare
	cmake_prepare
}

# @ECLASS_VARIABLE: MYCMAKEARGS
# @USER_VARIABLE
# @DESCRIPTION:
# User-controlled environment variable containing arguments to be passed to
# cmake in cmake_src_configure.

# @FUNCTION: cmake_src_configure
# @DESCRIPTION:
# General function for configuring with cmake. Default behaviour is to start an
# out-of-source build.
# Passes arguments to cmake by reading from an optionally pre-defined local
# mycmakeargs bash array.
# @CODE
# src_configure() {
# 	local mycmakeargs=(
# 		$(cmake_use_find_package foo LibFoo)
# 	)
# 	cmake_src_configure
# }
# @CODE
cmake_src_configure() {
	debug-print-function ${FUNCNAME} "$@"

	if [[ -z ${_CMAKE_PREPARE_HAS_RUN} ]]; then
		die "FATAL: cmake_src_prepare (or cmake_prepare) has not been run"
	fi

	_cmake_check_build_dir

	# Fix xdg collision with sandbox
	xdg_environment_reset

	local libdir=$(get_libdir)

	# Prepare Gentoo override rules (set valid compiler, append CPPFLAGS etc.)
	local build_rules=${BUILD_DIR}/gentoo_rules.cmake
	cat > "${build_rules}" <<- _EOF_ || die
		set(CMAKE_ASM_COMPILE_OBJECT "<CMAKE_ASM_COMPILER> <DEFINES> <INCLUDES> ${CPPFLAGS} <FLAGS> -o <OBJECT> -c <SOURCE>" CACHE STRING "ASM compile command" FORCE)
		set(CMAKE_ASM-ATT_COMPILE_OBJECT "<CMAKE_ASM-ATT_COMPILER> <DEFINES> <INCLUDES> ${CPPFLAGS} <FLAGS> -o <OBJECT> -c -x assembler <SOURCE>" CACHE STRING "ASM-ATT compile command" FORCE)
		set(CMAKE_ASM-ATT_LINK_FLAGS "-nostdlib" CACHE STRING "ASM-ATT link flags" FORCE)
		set(CMAKE_C_COMPILE_OBJECT "<CMAKE_C_COMPILER> <DEFINES> <INCLUDES> ${CPPFLAGS} <FLAGS> -o <OBJECT> -c <SOURCE>" CACHE STRING "C compile command" FORCE)
		set(CMAKE_CXX_COMPILE_OBJECT "<CMAKE_CXX_COMPILER> <DEFINES> <INCLUDES> ${CPPFLAGS} <FLAGS> -o <OBJECT> -c <SOURCE>" CACHE STRING "C++ compile command" FORCE)
		set(CMAKE_Fortran_COMPILE_OBJECT "<CMAKE_Fortran_COMPILER> <DEFINES> <INCLUDES> ${FCFLAGS} <FLAGS> -o <OBJECT> -c <SOURCE>" CACHE STRING "Fortran compile command" FORCE)

		# in Prefix we need rpath and must ensure cmake gets our default linker path
		# right ... except for Darwin hosts
		if($(usex prefix-guest 1 0)) # if use prefix-guest
			if(NOT APPLE)
				set(CMAKE_SKIP_RPATH OFF CACHE BOOL "" FORCE)
				set(CMAKE_PLATFORM_REQUIRED_RUNTIME_PATH "${EPREFIX}/usr/${CHOST}/lib/gcc;${EPREFIX}/usr/${CHOST}/lib;${EPREFIX}/usr/${libdir};${EPREFIX}/${libdir}" CACHE STRING "" FORCE)
			else()
				set(CMAKE_PREFIX_PATH "${EPREFIX}/usr" CACHE STRING "" FORCE)
				set(CMAKE_MACOSX_RPATH ON CACHE BOOL "" FORCE)
				set(CMAKE_SKIP_BUILD_RPATH OFF CACHE BOOL "" FORCE)
				set(CMAKE_SKIP_RPATH OFF CACHE BOOL "" FORCE)
				set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE CACHE BOOL "" FORCE)
			endif()
		endif()
	_EOF_

	local myCC=$(tc-getCC) myCXX=$(tc-getCXX) myFC=$(tc-getFC)

	# We are using the C compiler for assembly by default.
	local -x ASMFLAGS=${CFLAGS}
	local -x PKG_CONFIG=$(tc-getPKG_CONFIG)

	if tc-is-cross-compiler; then
		local sysname
		case "${KERNEL:-linux}" in
			Cygwin) sysname="CYGWIN_NT-5.1" ;;
			HPUX) sysname="HP-UX" ;;
			linux) sysname="Linux" ;;
			Winnt) sysname="Windows" ;;
			*) sysname="${KERNEL}" ;;
		esac
	fi

	# !!! IMPORTANT NOTE !!!
	# Single slash below is intentional. CMake is weird and wants the
	# CMAKE_*_VARIABLES split into two elements: the first one with
	# compiler path, and the second one with all command-line options,
	# space separated.
	local toolchain_file=${BUILD_DIR}/gentoo_toolchain.cmake
	cat > ${toolchain_file} <<- _EOF_ || die
		set(CMAKE_ASM_COMPILER "${myCC/ /;}")
		set(CMAKE_ASM-ATT_COMPILER "${myCC/ /;}")
		set(CMAKE_C_COMPILER "${myCC/ /;}")
		set(CMAKE_CXX_COMPILER "${myCXX/ /;}")
		set(CMAKE_Fortran_COMPILER "${myFC/ /;}")
		set(CMAKE_AR $(type -P $(tc-getAR)) CACHE FILEPATH "Archive manager" FORCE)
		set(CMAKE_RANLIB $(type -P $(tc-getRANLIB)) CACHE FILEPATH "Archive index generator" FORCE)
		set(CMAKE_SYSTEM_PROCESSOR "${CHOST%%-*}")

		# When building with a sysroot (e.g. with crossdev's emerge wrappers)
		# we need to tell cmake to use libs/headers from the sysroot but programs from / only.
		if($(if [[ ${SYSROOT:-/} != / ]] ; then echo 1; else echo 0; fi)) # if \${SYSROOT:-/} != /
			set(CMAKE_SYSROOT "${ESYSROOT}")
			set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
			set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
			set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
		endif()

		if($(tc-is-cross-compiler && echo 1 || echo 0)) # if tc-is-cross-compiler
			set(CMAKE_SYSTEM_NAME "${sysname}")
			if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
				set(CMAKE_RC_COMPILER $(tc-getRC))
			endif()
		endif()
	_EOF_

	# Common configure parameters (invariants)
	local common_config=${BUILD_DIR}/gentoo_common_config.cmake
	cat > "${common_config}" <<- _EOF_ || die
		set(CMAKE_GENTOO_BUILD ON CACHE BOOL "Indicate Gentoo package build")
		set(LIB_SUFFIX ${libdir/lib} CACHE STRING "library path suffix" FORCE)
		set(CMAKE_INSTALL_LIBDIR ${libdir} CACHE PATH "Output directory for libraries")
		set(CMAKE_INSTALL_INFODIR "${EPREFIX}/usr/share/info" CACHE PATH "")
		set(CMAKE_INSTALL_MANDIR "${EPREFIX}/usr/share/man" CACHE PATH "")
		set(CMAKE_USER_MAKE_RULES_OVERRIDE "${build_rules}" CACHE FILEPATH "Gentoo override rules")
		set(CMAKE_INSTALL_DOCDIR "${EPREFIX}/usr/share/doc/${PF}" CACHE PATH "")
		set(BUILD_SHARED_LIBS ON CACHE BOOL "")
		set(Python3_FIND_UNVERSIONED_NAMES FIRST CACHE STRING "") # FindPythonInterp, Gentoo-bug #835799
		set(CMAKE_POLICY_DEFAULT_CMP0094 NEW CACHE STRING "" ) # FindPython, Gentoo-bug #959154
		set(FETCHCONTENT_FULLY_DISCONNECTED ON CACHE BOOL "")
		set(CMAKE_DISABLE_PRECOMPILE_HEADERS ON CACHE BOOL "")
		set(CMAKE_INTERPROCEDURAL_OPTIMIZATION OFF CACHE BOOL "")
		set(CMAKE_TLS_VERIFY ON CACHE BOOL "")
		set(CMAKE_COMPILE_WARNING_AS_ERROR OFF CACHE BOOL "")
		set(CMAKE_LINK_WARNING_AS_ERROR OFF CACHE BOOL "")

		# See Gentoo-bug 689410
		if($(if [[ "${ARCH}" == riscv ]]; then echo 1; else echo 0; fi)) # if \${ARCH} == riscv
			set(CMAKE_FIND_LIBRARY_CUSTOM_LIB_SUFFIX '"${libdir#lib}"' CACHE STRING "library search suffix" FORCE)
		endif()

		if($(if [[ "${NOCOLOR}" = true || "${NOCOLOR}" = yes ]]; then echo 1; else echo 0; fi)) # if NOCOLOR=(true|yes)
			set(CMAKE_COLOR_MAKEFILE OFF CACHE BOOL "pretty colors during make" FORCE)
		endif()

		# Wipe the default optimization flags out of CMake
		set(CMAKE_ASM_FLAGS_${CMAKE_BUILD_TYPE^^} "" CACHE STRING "")
		set(CMAKE_ASM-ATT_FLAGS_${CMAKE_BUILD_TYPE^^} "" CACHE STRING "")
		set(CMAKE_C_FLAGS_${CMAKE_BUILD_TYPE^^} "" CACHE STRING "")
		set(CMAKE_CXX_FLAGS_${CMAKE_BUILD_TYPE^^} "" CACHE STRING "")
		set(CMAKE_Fortran_FLAGS_${CMAKE_BUILD_TYPE^^} "" CACHE STRING "")
		set(CMAKE_EXE_LINKER_FLAGS_${CMAKE_BUILD_TYPE^^} "" CACHE STRING "")
		set(CMAKE_MODULE_LINKER_FLAGS_${CMAKE_BUILD_TYPE^^} "" CACHE STRING "")
		set(CMAKE_SHARED_LINKER_FLAGS_${CMAKE_BUILD_TYPE^^} "" CACHE STRING "")
		set(CMAKE_STATIC_LINKER_FLAGS_${CMAKE_BUILD_TYPE^^} "" CACHE STRING "")
		set(CMAKE_INSTALL_ALWAYS 1) # see Gentoo-bug 735820
	_EOF_

	# Make the array a local variable since <=portage-2.1.6.x does not support
	# global arrays (see bug #297255). But first make sure it is initialised.
	[[ -z ${mycmakeargs} ]] && declare -a mycmakeargs=()
	local mycmakeargstype=$(declare -p mycmakeargs 2>&-)
	if [[ "${mycmakeargstype}" != "declare -a mycmakeargs="* ]]; then
		die "mycmakeargs must be declared as array"
	fi

	local mycmakeargs_local=( "${mycmakeargs[@]}" )

	local warn_unused_cli=""
	if [[ ${CMAKE_WARN_UNUSED_CLI} == no ]] ; then
		warn_unused_cli="--no-warn-unused-cli"
	fi

	local generator_name
	case ${CMAKE_MAKEFILE_GENERATOR} in
		ninja) generator_name="Ninja" ;;
		emake) generator_name="Unix Makefiles" ;;
	esac

	# Common configure parameters (overridable)
	# NOTE CMAKE_BUILD_TYPE can be only overridden via CMAKE_BUILD_TYPE eclass variable
	# No -DCMAKE_BUILD_TYPE=xxx definitions will be in effect.
	local cmakeargs=(
		${warn_unused_cli}
		-C "${common_config}"
		-G "${generator_name}"
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr"
		"${mycmakeargs_local[@]}"
		-DCMAKE_BUILD_TYPE="${CMAKE_BUILD_TYPE}"
		-DCMAKE_TOOLCHAIN_FILE="${toolchain_file}"
	)

	# Handle quoted whitespace
	eval "local -a MYCMAKEARGS=( ${MYCMAKEARGS} )"
	cmakeargs+=( "${MYCMAKEARGS[@]}" )

	if [[ -n "${CMAKE_EXTRA_CACHE_FILE}" ]] ; then
		cmakeargs+=( -C "${CMAKE_EXTRA_CACHE_FILE}" )
	fi

	[[ -n ${CMAKE_POLICY_VERSION_MINIMUM} ]] &&
		cmakeargs+=( -DCMAKE_POLICY_VERSION_MINIMUM=${CMAKE_POLICY_VERSION_MINIMUM} )

	pushd "${BUILD_DIR}" > /dev/null || die
	debug-print "${LINENO} ${ECLASS} ${FUNCNAME}: mycmakeargs is ${mycmakeargs_local[*]}"
	echo "${CMAKE_BINARY}" "${cmakeargs[@]}" "${CMAKE_USE_DIR}"
	"${CMAKE_BINARY}" "${cmakeargs[@]}" "${CMAKE_USE_DIR}" || die "cmake failed"
	popd > /dev/null || die
}

# @FUNCTION: cmake_src_compile
# @DESCRIPTION:
# General function for compiling with cmake. All arguments are passed
# to cmake_build.
cmake_src_compile() {
	debug-print-function ${FUNCNAME} "$@"

	cmake_build "$@"
}

# @FUNCTION: cmake_build
# @DESCRIPTION:
# Function for building the package. Automatically detects the build type.
# All arguments are passed to eninja (default) or emake depending on the value
# of CMAKE_MAKEFILE_GENERATOR.
cmake_build() {
	debug-print-function ${FUNCNAME} "$@"

	_cmake_check_build_dir
	pushd "${BUILD_DIR}" > /dev/null || die

	case ${CMAKE_MAKEFILE_GENERATOR} in
		emake)
			[[ -e Makefile ]] || die "Makefile not found. Error during configure stage."
			case ${CMAKE_VERBOSE} in
				OFF) emake "$@" ;;
				*) emake VERBOSE=1 "$@" ;;
			esac
			;;
		ninja)
			[[ -e build.ninja ]] || die "build.ninja not found. Error during configure stage."
			case ${CMAKE_VERBOSE} in
				OFF) NINJA_VERBOSE=OFF eninja "$@" ;;
				*) eninja "$@" ;;
			esac
			;;
	esac

	local rc=$? # save build tool's exit code in case of running under nonfatal
	popd > /dev/null || die
	return $rc
}

# @ECLASS_VARIABLE: CTEST_JOBS
# @USER_VARIABLE
# @DESCRIPTION:
# Maximum number of CTest jobs to run in parallel.  If unset, the value
# will be determined from make options.

# @ECLASS_VARIABLE: CTEST_LOADAVG
# @USER_VARIABLE
# @DESCRIPTION:
# Maximum load, over which no new jobs will be started by CTest.  Note
# that unlike make, CTest will not start *any* jobs if the load
# is exceeded.  If unset, the value will be determined from make options.

# @FUNCTION: cmake_src_test
# @DESCRIPTION:
# Function for testing the package. Automatically detects the build type.
cmake_src_test() {
	debug-print-function ${FUNCNAME} "$@"

	_cmake_check_build_dir
	pushd "${BUILD_DIR}" > /dev/null || die
	[[ -e CTestTestfile.cmake ]] || { echo "No tests found. Skipping."; return 0 ; }

	[[ -n ${TEST_VERBOSE} ]] && myctestargs+=( --extra-verbose --output-on-failure )
	[[ -n ${CMAKE_SKIP_TESTS} ]] && myctestargs+=( -E '('$( IFS='|'; echo "${CMAKE_SKIP_TESTS[*]}")')'  )

	set -- ctest -j "${CTEST_JOBS:-$(get_makeopts_jobs 999)}" \
		--test-load "${CTEST_LOADAVG:-$(get_makeopts_loadavg)}" \
		"${myctestargs[@]}" "$@"
	echo "$@" >&2
	if "$@" ; then
		einfo "Tests succeeded."
		popd > /dev/null || die
		return 0
	else
		if [[ -n "${CMAKE_YES_I_WANT_TO_SEE_THE_TEST_LOG}" ]] ; then
			# on request from Diego
			eerror "Tests failed. Test log ${BUILD_DIR}/Testing/Temporary/LastTest.log follows:"
			eerror "--START TEST LOG--------------------------------------------------------------"
			cat "${BUILD_DIR}/Testing/Temporary/LastTest.log"
			eerror "--END TEST LOG----------------------------------------------------------------"
			die -n "Tests failed."
		else
			eerror "Tests failed. When you file a bug, please attach the following file:"
			eerror "\t${BUILD_DIR}/Testing/Temporary/LastTest.log"
			die -n "Tests failed."
		fi

		# die might not die due to nonfatal
		popd > /dev/null || die
		return 1
	fi
}

# @FUNCTION: cmake_src_install
# @DESCRIPTION:
# Function for installing the package. Automatically detects the build type.
cmake_src_install() {
	debug-print-function ${FUNCNAME} "$@"

	DESTDIR="${D}" cmake_build "$@" install

	pushd "${CMAKE_USE_DIR}" > /dev/null || die
		einstalldocs
	popd > /dev/null || die

	cmake_minreqver_qainfo
}

fi

EXPORT_FUNCTIONS src_prepare src_configure src_compile src_test src_install
