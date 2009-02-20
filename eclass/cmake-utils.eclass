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

inherit toolchain-funcs multilib flag-o-matic

DESCRIPTION="Based on the ${ECLASS} eclass"

DEPEND=">=dev-util/cmake-2.4.6"

case ${EAPI} in
	2)
		EXPORT_FUNCTIONS src_configure src_compile src_test src_install
		;;
	*)
		EXPORT_FUNCTIONS src_compile src_test src_install
		;;
esac


# Internal function use by cmake-utils_use_with and cmake-utils_use_enable
_use_me_now() {
	debug-print-function $FUNCNAME $*
	[[ -z $2 ]] && die "cmake-utils_use-$1 <USE flag> [<flag name>]"
	echo "-D$1_${3:-$2}=$(use $2 && echo ON || echo OFF)"
}

# @VARIABLE: DOCS
# @DESCRIPTION:
# Documents to dodoc

# @VARIABLE: CMAKE_BUILD_DIR
# @DESCRIPTION:
# Determine using IN or OUT source build
if [[ -n "${CMAKE_IN_SOURCE_BUILD}" ]]; then
	CMAKE_BUILD_DIR="${S}"
else
	CMAKE_BUILD_DIR="${WORKDIR}/${PN}_build"
fi

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

# @FUNCTION: cmake-utils_use_want
# @USAGE: <USE flag> [flag name]
# @DESCRIPTION:
# Based on use_enable. See ebuild(5).
#
# `cmake-utils_use_want foo FOO` echoes -DWANT_FOO=ON if foo is enabled
# and -DWANT_FOO=OFF if it is disabled.
cmake-utils_use_want() { _use_me_now WANT "$@" ; }

# @FUNCTION: cmake-utils_has
# @USAGE: <USE flag> [flag name]
# @DESCRIPTION:
# Based on use_enable. See ebuild(5).
#
# `cmake-utils_has foo FOO` echoes -DHAVE_FOO=ON if foo is enabled
# and -DHAVE_FOO=OFF if it is disabled.
cmake-utils_has() { _use_me_now HAVE "$@" ; }

# @FUNCTION: cmake-utils_src_configure
# @DESCRIPTION:
# General function for configuring with cmake. Default behaviour is to start an
# out-of-source build.
cmake-utils_src_configure() {
	debug-print-function $FUNCNAME $*

	_common_configure_code
	local cmakeargs="${mycmakeargs} ${EXTRA_ECONF} -DCMAKE_INSTALL_DO_STRIP=OFF"
	mkdir -p "${CMAKE_BUILD_DIR}"
	pushd "${CMAKE_BUILD_DIR}" > /dev/null

	debug-print "$LINENO $ECLASS $FUNCNAME: mycmakeargs is $cmakeargs"
	cmake -C "${TMPDIR}/gentoo_common_config.cmake" ${cmakeargs} "${S}" || die "Cmake failed"

	popd > /dev/null
}

# @FUNCTION: cmake-utils_src_compile
# @DESCRIPTION:
# General function for compiling with cmake. Default behaviour is to check for
# eapi and based on it configure or only compile
cmake-utils_src_compile() {
	case ${EAPI} in
		2)
		;;
	*)
		cmake-utils_src_configure
		;;
	esac

	cmake-utils_src_make "$@"
}

# @FUNCTION: cmake-utils_src_configurein
# @DESCRIPTION:
# Depercated
cmake-utils_src_configurein() {
	ewarn "This ebuild is using deprecated function call: $FUNCNAME"
	cmake-utils_src_configure
}

# @FUNCTION: cmake-utils_src_configureout
# @DESCRIPTION:
# Depercated
cmake-utils_src_configureout() {
	ewarn "This ebuild is using deprecated function call: $FUNCNAME"
	cmake-utils_src_configure
}

# Internal use only. Common configuration options for all types of builds.
_common_configure_code() {
	local tmp_libdir=$(get_libdir)
	# here we set the compiler explicitly, set install directories prefixes, and
	# make sure that the gentoo user compiler flags trump those set in the
	# program
	local modules_dir=/usr/share/cmake/Modules
	local cxx_create_shared_library=$(sed -n -e 's/)/ CACHE STRING "")/' -e "s/<TARGET_SONAME>/<TARGET_SONAME> ${CXXFLAGS}/" -e '/SET(CMAKE_CXX_CREATE_SHARED_LIBRARY/,/)/p' "${modules_dir}/CMakeCXXInformation.cmake")
	local c_create_shared_library=$(sed -n -e 's/)/ CACHE STRING "")/' -e "s/<TARGET_SONAME>/<TARGET_SONAME> ${CFLAGS}/" -e '/SET(CMAKE_C_CREATE_SHARED_LIBRARY/,/)/p' "${modules_dir}/CMakeCInformation.cmake")
	local c_compile_object=$(sed -n -e 's/)/ CACHE STRING "")/' -e "s/<FLAGS>/<FLAGS> ${CFLAGS}/" -e '/SET(CMAKE_C_COMPILE_OBJECT/,/)/p' "${modules_dir}/CMakeCInformation.cmake")
	local cxx_compile_object=$(sed -n -e 's/)/ CACHE STRING "")/' -e "s/<FLAGS>/<FLAGS> ${CXXFLAGS}/" -e '/SET(CMAKE_CXX_COMPILE_OBJECT/,/)/p' "${modules_dir}/CMakeCXXInformation.cmake")
	local c_link_executable=$(sed -n -e 's/)/ CACHE STRING "")/' -e "s/<FLAGS>/<FLAGS> ${CFLAGS}/" -e "s/<LINK_FLAGS>/<LINK_FLAGS> ${LDFLAGS}/" -e '/SET(CMAKE_C_LINK_EXECUTABLE/,/)/p' "${modules_dir}/CMakeCInformation.cmake")
	local cxx_link_executable=$(sed -n -e 's/)/ CACHE STRING "")/' -e "s/<FLAGS>/<FLAGS> ${CXXFLAGS}/" -e "s/<LINK_FLAGS>/<LINK_FLAGS> ${LDFLAGS}/" -e '/SET(CMAKE_CXX_LINK_EXECUTABLE/,/)/p' "${modules_dir}/CMakeCXXInformation.cmake")
	cat > "${TMPDIR}/gentoo_common_config.cmake" <<_EOF_
SET(CMAKE_C_COMPILER $(type -P $(tc-getCC)) CACHE STRING "package building C compiler")
SET(CMAKE_CXX_COMPILER $(type -P $(tc-getCXX)) CACHE STRING "package building C++ compiler")
${c_create_shared_library}
${cxx_create_shared_library}
${c_compile_object}
${cxx_compile_object}
${c_link_executable}
${cxx_link_executable}
SET(CMAKE_INSTALL_PREFIX ${PREFIX:-/usr} CACHE FILEPATH "install path prefix")
SET(LIB_SUFFIX ${tmp_libdir/lib} CACHE FILEPATH "library path suffix")
SET(LIB_INSTALL_DIR ${PREFIX:-/usr}/${tmp_libdir} CACHE FILEPATH "library install directory")

_EOF_

	[[ -n ${CMAKE_NO_COLOR} ]] && echo 'SET(CMAKE_COLOR_MAKEFILE OFF CACHE BOOL "pretty colors during make")' >> "${TMPDIR}/gentoo_common_config.cmake"

	# honour gentoo c and cxx flags settings instead of using system ones.
	echo 'SET(CMAKE_BUILD_TYPE gentoo CACHE STRING "determines build settings")' >> "${TMPDIR}/gentoo_common_config.cmake"
	echo "SET(CMAKE_CXX_FLAGS_GENTOO \"${CXXFLAGS}\")" >> "${TMPDIR}/gentoo_common_config.cmake"
	echo "SET(CMAKE_C_FLAGS_GENTOO \"${CFLAGS}\")" >> "${TMPDIR}/gentoo_common_config.cmake"
}

# @FUNCTION: cmake-utils_src_make
# @DESCRIPTION:
# Function for building the package. Automatically detects the build type.
# All arguments are passed to emake:
# "cmake-utils_src_make -j1" can be used to work around parallel make issues.
cmake-utils_src_make() {
	debug-print-function $FUNCNAME $*

	pushd "${CMAKE_BUILD_DIR}" > /dev/null
	if ! [[ -z ${CMAKE_COMPILER_VERBOSE} ]]; then
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
	debug-print-function $FUNCNAME $*


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
	debug-print-function $FUNCNAME $*

	# At this point we can automatically check if it's an out-of-source or an
	# in-source build
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
