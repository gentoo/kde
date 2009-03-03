# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/cmake-utils.eclass,v 1.16 2008/12/24 15:41:06 scarabeus Exp $

# @ECLASS: cmake-utils.eclass
# @MAINTAINER:
# kde@gentoo.org
# @BLURB: common ebuild functions for cmake-based packages
# @DESCRIPTION:
# The cmake-utils eclass contains functions that make creating ebuilds for
# cmake-based packages much easier.
# Its main features are support of out-of-source builds as well as in-source
# builds and an implementation of the well-known use_enable and use_with
# functions for CMake.

# Original author: Zephyrus (zephyrus@mirach.it)

inherit toolchain-funcs multilib flag-o-matic base

DESCRIPTION="Based on the ${ECLASS} eclass"

DEPEND=">=dev-util/cmake-2.4.6"

case ${EAPI} in
	2)
		EXPORT_FUNCTIONS src_unpack src_prepare src_configure src_compile src_test src_install
		;;
	*)
		EXPORT_FUNCTIONS src_compile src_test src_install
		;;
esac

# Internal functions used by cmake-utils_use_*
_use_me_now() {
	debug-print-function $FUNCNAME "$@"
	[[ -z $2 ]] && die "cmake-utils_use-$1 <USE flag> [<flag name>]"
	echo "-D$1_${3:-$2}=$(use $2 && echo ON || echo OFF)"
}
_use_me_now_inverted() {
	debug-print-function $FUNCNAME "$@"
	[[ -z $2 ]] && die "cmake-utils_use-$1 <USE flag> [<flag name>]"
	echo "-D$1_${3:-$2}=$(use $2 && echo OFF || echo ON)"
}

# @ECLASS-VARIABLE: DOCS
# @DESCRIPTION:
# Documents which are passed to dodoc command.
: ${DOCS:=}

# @ECLASS-VARIABLE: CMAKE_IN_SOURCE_BUILD
# @DESCRIPTION:
# Set to enable in-source build.
: ${CMAKE_IN_SOURCE_BUILD:=}

# @ECLASS-VARIABLE: CMAKE_NO_COLOR
# @DESCRIPTION:
# Set to disable cmake output coloring.
: ${CMAKE_NO_COLOR:=}

# @ECLASS-VARIABLE: CMAKE_VERBOSE
# @DESCRIPTION:
# Set to enable verbose messages during compilation.
: ${CMAKE_VERBOSE:=}

# @ECLASS-VARIABLE: CMAKE_BUILD_TYPE
# @DESCRIPTION:
# Set to override default CMAKE_BUILD_TYPE. Only useful for packages
# known to make use of "if (CMAKE_BUILD_TYPE MATCHES xxx)".
CMAKE_BUILD_TYPE="${CMAKE_BUILD_TYPE:=}"
export CMAKE_BUILD_TYPE

# Internal function. Determine using IN or OUT source build
_check_build_dir() {
	# in/out source build
	if [[ -n "${CMAKE_IN_SOURCE_BUILD}" ]]; then
		CMAKE_BUILD_DIR="${S}"
	else
		CMAKE_BUILD_DIR="${WORKDIR}/${PN}_build"
	fi
}
# @FUNCTION: cmake-utils_use_with
# @USAGE: <USE flag> [flag name]
# @DESCRIPTION:
# Based on use_with. See ebuild(5).
#
# `cmake-utils_use_with foo FOO` echoes -DWITH_FOO=ON if foo is enabled
# and -DWITH_FOO=OFF if it is disabled.
cmake-utils_use_with() { _use_me_now WITH "$@" ; }

# @FUNCTION: cmake-utils_use_enable
# @USAGE: <USE flag> [flag name]
# @DESCRIPTION:
# Based on use_enable. See ebuild(5).
#
# `cmake-utils_use_enable foo FOO` echoes -DENABLE_FOO=ON if foo is enabled
# and -DENABLE_FOO=OFF if it is disabled.
cmake-utils_use_enable() { _use_me_now ENABLE "$@" ; }

# @FUNCTION: cmake-utils_use_disable
# @USAGE: <USE flag> [flag name]
# @DESCRIPTION:
# Based on inversion of use_enable. See ebuild(5).
#
# `cmake-utils_use_enable foo FOO` echoes -DDISABLE_FOO=OFF if foo is enabled
# and -DDISABLE_FOO=ON if it is disabled.
cmake-utils_use_disable() { _use_me_now_inverted DISABLE "$@" ; }

# @FUNCTION: cmake-utils_use_want
# @USAGE: <USE flag> [flag name]
# @DESCRIPTION:
# Based on use_enable. See ebuild(5).
#
# `cmake-utils_use_want foo FOO` echoes -DWANT_FOO=ON if foo is enabled
# and -DWANT_FOO=OFF if it is disabled.
cmake-utils_use_want() { _use_me_now WANT "$@" ; }

# @FUNCTION: cmake-utils_use_build
# @USAGE: <USE flag> [flag name]
# @DESCRIPTION:
# Based on use_enable. See ebuild(5).
#
# `cmake-utils_use_build foo FOO` echoes -DBUILD_FOO=ON if foo is enabled
# and -DBUILD_FOO=OFF if it is disabled.
cmake-utils_use_build() { _use_me_now BUILD "$@" ; }

# @FUNCTION: cmake-utils_has
# @USAGE: <USE flag> [flag name]
# @DESCRIPTION:
# Based on use_enable. See ebuild(5).
#
# `cmake-utils_has foo FOO` echoes -DHAVE_FOO=ON if foo is enabled
# and -DHAVE_FOO=OFF if it is disabled.
cmake-utils_has() { _use_me_now HAVE "$@" ; }

# @FUNCTION: cmake-utils_src_unpack
# @DESCRIPTION:
# General function for src_prepare with cmake. Main purpose is to strip hardcoded
# build type definitions and override cmake default build type specific flags.
# Autopatcher is available.
cmake-utils_src_unpack() {
	debug-print-function $FUNCNAME "$@"

	# Unpack only if not done already
	[[ ! -d "${S}" ]] && base_src_unpack

	case ${EAPI} in
		2) ;;
		*) cmake-utils_src_prepare ;;
	esac
}

# @FUNCTION: cmake-utils_src_prepare
# @DESCRIPTION:
# General function for src_prepare with cmake. Main purpose is to strip hardcoded
# build type definitions and override cmake default build type specific flags.
# Autopatcher is available.
cmake-utils_src_prepare() {
	debug-print-function $FUNCNAME "$@"

	# Invoke autopatcher
	base_src_prepare

	# Comment out all set (CMAKE_BUILD_TYPE )
	# TODO add QA checker - inform when build type is set in CMakeLists.txt
	find "${S}" -name CMakeLists.txt \
		-exec sed -i -e '/^[[:space:]]*[sS][eE][tT][[:space:]]*([[:space:]]*CMAKE_BUILD_TYPE.*)/{s/^/#IGNORE /g}' {} + \
		|| die "${LINENO}: failed to disable hardcoded built type specifiers"

	# @SEE CMAKE_BUILD_TYPE
	if [[ -z ${CMAKE_BUILD_TYPE} ]]; then
		# Handle common debug/release builds
		if has debug ${IUSE//+} && use debug; then
			CMAKE_BUILD_TYPE="Debug"
		else
			append-cppflags -DNDEBUG
			CMAKE_BUILD_TYPE="Release"
		fi
	fi

	# Prepare Gentoo build configuration
	local gentoo_config="${TMPDIR}"/gentoo_config.cmake
	local libdir=$(get_libdir)
	local build_type=`echo ${CMAKE_BUILD_TYPE} | tr [:lower:] [:upper:]`
	cat > ${gentoo_config} <<_EOF_

# <<< BEGIN GENTOO MAGIC >>>
# Clear build type specific settings
SET (CMAKE_BUILD_TYPE ${CMAKE_BUILD_TYPE} CACHE STRING "build configuration" FORCE)
SET (CMAKE_C_FLAGS_${build_type} CACHE STRING "C compiler flags" FORCE)
SET (CMAKE_CXX_FLAGS_${build_type} CACHE STRING "C++ compiler flags" FORCE)
# Prefixes
SET (CMAKE_INSTALL_PREFIX ${PREFIX:-/usr} CACHE FILEPATH "install path prefix" FORCE)
SET (LIB_SUFFIX ${libdir/lib} CACHE FILEPATH "library path suffix" FORCE)
SET (LIB_INSTALL_DIR ${PREFIX:-/usr}/${libdir} CACHE FILEPATH "library install directory" FORCE)
# Misc settings
SET (CMAKE_INSTALL_DO_STRIP OFF CACHE BOOL "stripping symbols upon install" FORCE)
_EOF_
	[[ -n ${CMAKE_NO_COLOR} ]] && echo 'SET (CMAKE_COLOR_MAKEFILE OFF CACHE BOOL "pretty colors during make")' >> ${gentoo_config}
	echo "# <<< END GENTOO MAGIC >>>" >> ${gentoo_config}

	# Inject configuration into toplevel CMakeLists.txt - it's the most reliable way of overriding hardcoded values
	cat ${gentoo_config} >> CMakeLists.txt || die "Failed to inject build configuration"
}

# @FUNCTION: cmake-utils_src_configure
# @DESCRIPTION:
# General function for configuring with cmake. Default behaviour is to start an
# out-of-source build.
cmake-utils_src_configure() {
	debug-print-function $FUNCNAME "$@"

	# Honor append-cppflags (preprocessor flags) - we need it here to capture all
	# definitions added in <= src_configure
	CFLAGS="${CPPFLAGS} ${CFLAGS}"
	CXXFLAGS="${CPPFLAGS} ${CXXFLAGS}"

	_check_build_dir

	local cmakeargs="${mycmakeargs} ${EXTRA_ECONF}"
	mkdir -p "${CMAKE_BUILD_DIR}"
	pushd "${CMAKE_BUILD_DIR}" > /dev/null
	debug-print "${LINENO} ${ECLASS} ${FUNCNAME}: mycmakeargs is $cmakeargs"
	cmake ${cmakeargs} "${S}" || die "cmake failed"

	popd > /dev/null
}

# @FUNCTION: cmake-utils_src_compile
# @DESCRIPTION:
# General function for compiling with cmake. Default behaviour is to check for
# eapi and based on it configure or only compile
cmake-utils_src_compile() {
	debug-print-function $FUNCNAME "$@"

	case ${EAPI} in
		2) ;;
		*) cmake-utils_src_configure ;;
	esac

	cmake-utils_src_make "$@"
}

# @FUNCTION: cmake-utils_src_configurein
# @DESCRIPTION:
# Depercated in fawor of cmake-utils_src_configure
cmake-utils_src_configurein() {
	ewarn "This ebuild is using deprecated function call: $FUNCNAME"
	ewarn "Inform ebuild maintainer."
	cmake-utils_src_configure
}

# @FUNCTION: cmake-utils_src_configureout
# @DESCRIPTION:
# Depercated in fawor of cmake-utils_src_configure
cmake-utils_src_configureout() {
	ewarn "This ebuild is using deprecated function call: $FUNCNAME"
	ewarn "Inform ebuild maintainer."
	cmake-utils_src_configure
}

# @FUNCTION: cmake-utils_src_make
# @DESCRIPTION:
# Function for building the package. Automatically detects the build type.
# All arguments are passed to emake:
cmake-utils_src_make() {
	debug-print-function $FUNCNAME "$@"

	_check_build_dir
	pushd "${CMAKE_BUILD_DIR}" > /dev/null
	if [[ -n ${CMAKE_VERBOSE} ]]; then
		emake VERBOSE=1 "$@" || die "Make failed!"
	else
		emake "$@" || die "Make failed!"
	fi
	popd > /dev/null
}

# @FUNCTION: cmake-utils_src_install
# @DESCRIPTION:
# Function for installing the package. Automatically detects the build type.
cmake-utils_src_install() {
	debug-print-function $FUNCNAME "$@"

	_check_build_dir
	pushd "${CMAKE_BUILD_DIR}" > /dev/null
	emake install DESTDIR="${D}" || die "Make install failed"
	popd > /dev/null

	# Manual document installation
	[[ -n "${DOCS}" ]] && dodoc ${DOCS}
}

# @FUNCTION: cmake-utils_src_test
# @DESCRIPTION:
# Function for testing the package. Automatically detects the build type.
cmake-utils_src_test() {
	debug-print-function $FUNCNAME "$@"

	_check_build_dir
	pushd "${CMAKE_BUILD_DIR}" > /dev/null
	# Standard implementation of src_test
	if emake -j1 check -n &> /dev/null; then
		einfo ">>> Test phase [check]: ${CATEGORY}/${PF}"
		if ! emake -j1 check; then
			die "Make check failed. See above for details."
		fi
	elif emake -j1 test -n &> /dev/null; then
		einfo ">>> Test phase [test]: ${CATEGORY}/${PF}"
		if ! emake -j1 test; then
			die "Make test failed. See above for details."
		fi
	else
		einfo ">>> Test phase [none]: ${CATEGORY}/${PF}"
	fi
	popd > /dev/null
}
