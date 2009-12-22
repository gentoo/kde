# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/cmake-utils.eclass,v 1.38 2009/12/18 10:49:55 zmedico Exp $

# @ECLASS: cmake-utils.eclass
# @MAINTAINER:
# kde@gentoo.org
#
# @CODE
# Tomáš Chvátal <scarabeus@gentoo.org>
# Maciej Mrozowski <reavertm@poczta.fm>
# (undisclosed contributors)
# Original author: Zephyrus (zephyrus@mirach.it)
# @CODE
# @BLURB: common ebuild functions for cmake-based packages
# @DESCRIPTION:
# The cmake-utils eclass contains functions that make creating ebuilds for
# cmake-based packages much easier.
# Its main features are support of out-of-source builds as well as in-source
# builds and an implementation of the well-known use_enable and use_with
# functions for CMake.

# @ECLASS-VARIABLE: WANT_CMAKE
# @DESCRIPTION:
# Specify if cmake-utils eclass should depend on cmake optionaly or not.
# This is usefull when only part of aplication is using cmake build system.
# Valid values are: always [default], optional (where the value is the useflag
# used for optionality)
WANT_CMAKE="${WANT_CMAKE:-always}"
CMAKEDEPEND=""
case ${WANT_CMAKE} in
	    always)
			;;
		*)
			IUSE+=" ${WANT_CMAKE}"
			CMAKEDEPEND+="${WANT_CMAKE}? ( "
			;;
esac
inherit toolchain-funcs multilib flag-o-matic base

CMAKE_EXPF="src_compile src_test src_install"
case ${EAPI:-0} in
	3|2) CMAKE_EXPF+=" src_configure" ;;
	1|0) ;;
	*) die "Unknown EAPI, Bug eclass maintainers." ;;
esac
EXPORT_FUNCTIONS ${CMAKE_EXPF}

: ${DESCRIPTION:="Based on the ${ECLASS} eclass"}

if [[ ${PN} != cmake ]]; then
	CMAKEDEPEND+=">=dev-util/cmake-2.6.2-r1"
fi

CMAKEDEPEND+=" userland_GNU? ( >=sys-apps/findutils-4.4.0 )"

[[ ${WANT_CMAKE} = always ]] || CMAKEDEPEND+=" )"

DEPEND="${CMAKEDEPEND}"
unset CMAKEDEPEND

# Internal functions used by cmake-utils_use_*
_use_me_now() {
	debug-print-function ${FUNCNAME} "$@"

	local uper capitalised x
	[[ -z $2 ]] && die "cmake-utils_use-$1 <USE flag> [<flag name>]"
	if [[ ! -z $3 ]]; then
		# user specified the use name so use it
		echo "-D$1$3=$(use $2 && echo ON || echo OFF)"
	else
		# use all various most used combinations
		uper=$(echo ${2} | tr '[:lower:]' '[:upper:]')
		capitalised=$(echo ${2} | sed 's/\<\(.\)\([^ ]*\)/\u\1\L\2/g')
		for x in $2 $uper $capitalised; do
			echo "-D$1$x=$(use $2 && echo ON || echo OFF) "
		done
	fi
}
_use_me_now_inverted() {
	debug-print-function ${FUNCNAME} "$@"

	local uper capitalised x
	[[ -z $2 ]] && die "cmake-utils_use-$1 <USE flag> [<flag name>]"
	if [[ ! -z $3 ]]; then
		# user specified the use name so use it
		echo "-D$1$3=$(use $2 && echo OFF || echo ON)"
	else
		# use all various most used combinations
		uper=$(echo ${2} | tr '[:lower:]' '[:upper:]')
		capitalised=$(echo ${2} | sed 's/\<\(.\)\([^ ]*\)/\u\1\L\2/g')
		for x in $2 $uper $capitalised; do
			echo "-D$1$x=$(use $2 && echo OFF || echo ON) "
		done
	fi
}

# @ECLASS-VARIABLE: DOCS
# @DESCRIPTION:
# Documents passed to dodoc command.

# @ECLASS-VARIABLE: HTML_DOCS
# @DESCRIPTION:
# Documents passed to dohtml command.

# @ECLASS-VARIABLE: PREFIX
# @DESCRIPTION:
# Eclass respects PREFIX variable, though it's not recommended way to set
# install/lib/bin prefixes.
# Use -DCMAKE_INSTALL_PREFIX=... CMake variable instead.

# @ECLASS-VARIABLE: CMAKE_IN_SOURCE_BUILD
# @DESCRIPTION:
# Set to enable in-source build.

# @ECLASS-VARIABLE: CMAKE_NO_COLOR
# @DESCRIPTION:
# Set to disable cmake output coloring.

# @ECLASS-VARIABLE: CMAKE_VERBOSE
# @DESCRIPTION:
# Set to enable verbose messages during compilation.

# @ECLASS-VARIABLE: CMAKE_BUILD_TYPE
# @DESCRIPTION:
# Set to override default CMAKE_BUILD_TYPE. Only useful for packages
# known to make use of "if (CMAKE_BUILD_TYPE MATCHES xxx)".
# If about to be set - needs to be set before invoking cmake-utils_src_configure.
# You usualy do *NOT* want nor need to set it as it pulls CMake default build-type
# specific compiler flags overriding make.conf.
: ${CMAKE_BUILD_TYPE:=Gentoo}

# @FUNCTION: _check_build_dir
# @DESCRIPTION:
# Determine using IN or OUT source build
_check_build_dir() {
	# @ECLASS-VARIABLE: CMAKE_USE_DIR
	# @DESCRIPTION:
	# Sets the directory where we are working with cmake.
	# For example when application uses autotools and only one
	# plugin needs to be done by cmake.
	# By default it uses ${S}.
	: ${CMAKE_USE_DIR:=${S}}

	# @ECLASS-VARIABLE: CMAKE_BUILD_DIR
	# @DESCRIPTION:
	# Specify the build directory where all cmake processed
	# files should be located.
	#
	# For installing binary doins "${CMAKE_BUILD_DIR}/${PN}"
	if [[ -n ${CMAKE_IN_SOURCE_BUILD} ]]; then
		# we build in source dir
		CMAKE_BUILD_DIR="${CMAKE_USE_DIR}"
	elif [[ ${CMAKE_USE_DIR} = ${WORKDIR} ]]; then
		# out of tree build, but with $S=$WORKDIR, see bug #273949 for reason.
		CMAKE_BUILD_DIR="${CMAKE_USE_DIR}/build"
	else
		# regular out of tree build
		[[ ${1} = init || -d ${CMAKE_USE_DIR}_build ]] && SUF="_build" || SUF=""
		CMAKE_BUILD_DIR="${CMAKE_USE_DIR}${SUF}"

	fi
	echo ">>> Working in BUILD_DIR: \"$CMAKE_BUILD_DIR\""
}
# @FUNCTION: cmake-utils_use_with
# @USAGE: <USE flag> [flag name]
# @DESCRIPTION:
# Based on use_with. See ebuild(5).
#
# `cmake-utils_use_with foo FOO` echoes -DWITH_FOO=ON if foo is enabled
# and -DWITH_FOO=OFF if it is disabled.
cmake-utils_use_with() { _use_me_now WITH_ "$@" ; }

# @FUNCTION: cmake-utils_use_enable
# @USAGE: <USE flag> [flag name]
# @DESCRIPTION:
# Based on use_enable. See ebuild(5).
#
# `cmake-utils_use_enable foo FOO` echoes -DENABLE_FOO=ON if foo is enabled
# and -DENABLE_FOO=OFF if it is disabled.
cmake-utils_use_enable() { _use_me_now ENABLE_ "$@" ; }

# @FUNCTION: cmake-utils_use_disable
# @USAGE: <USE flag> [flag name]
# @DESCRIPTION:
# Based on inversion of use_enable. See ebuild(5).
#
# `cmake-utils_use_enable foo FOO` echoes -DDISABLE_FOO=OFF if foo is enabled
# and -DDISABLE_FOO=ON if it is disabled.
cmake-utils_use_disable() { _use_me_now_inverted DISABLE_ "$@" ; }

# @FUNCTION: cmake-utils_use_no
# @USAGE: <USE flag> [flag name]
# @DESCRIPTION:
# Based on use_disable. See ebuild(5).
#
# `cmake-utils_use_no foo FOO` echoes -DNO_FOO=OFF if foo is enabled
# and -DNO_FOO=ON if it is disabled.
cmake-utils_use_no() { _use_me_now_inverted NO_ "$@" ; }

# @FUNCTION: cmake-utils_use_want
# @USAGE: <USE flag> [flag name]
# @DESCRIPTION:
# Based on use_enable. See ebuild(5).
#
# `cmake-utils_use_want foo FOO` echoes -DWANT_FOO=ON if foo is enabled
# and -DWANT_FOO=OFF if it is disabled.
cmake-utils_use_want() { _use_me_now WANT_ "$@" ; }

# @FUNCTION: cmake-utils_use_build
# @USAGE: <USE flag> [flag name]
# @DESCRIPTION:
# Based on use_enable. See ebuild(5).
#
# `cmake-utils_use_build foo FOO` echoes -DBUILD_FOO=ON if foo is enabled
# and -DBUILD_FOO=OFF if it is disabled.
cmake-utils_use_build() { _use_me_now BUILD_ "$@" ; }

# @FUNCTION: cmake-utils_use_has
# @USAGE: <USE flag> [flag name]
# @DESCRIPTION:
# Based on use_enable. See ebuild(5).
#
# `cmake-utils_use_has foo FOO` echoes -DHAVE_FOO=ON if foo is enabled
# and -DHAVE_FOO=OFF if it is disabled.
cmake-utils_use_has() { _use_me_now HAVE_ "$@" ; }

# @FUNCTION: cmake-utils_use
# @USAGE: <USE flag> [flag name]
# @DESCRIPTION:
# Based on use_enable. See ebuild(5).
#
# `cmake-utils_use foo FOO` echoes -DFOO=ON if foo is enabled
# and -DFOO=OFF if it is disabled.
cmake-utils_use() { _use_me_now "" "$@" ; }

# Internal function for modifying hardcoded definitions.
# Removes dangerous definitionts that override Gentoo settings.
_modify-cmakelists() {
	debug-print-function ${FUNCNAME} "$@"

	# Comment out all set (<some_should_be_user_defined_variable> value)
	# TODO Add QA checker - inform when variable being checked for below is set in CMakeLists.txt
	find "${CMAKE_USE_DIR}" -name CMakeLists.txt \
		-exec sed -i -e '/^[[:space:]]*[sS][eE][tT][[:space:]]*([[:space:]]*CMAKE_BUILD_TYPE.*)/{s/^/#IGNORE /g}' {} + \
		-exec sed -i -e '/^[[:space:]]*[sS][eE][tT][[:space:]]*([[:space:]]*CMAKE_INSTALL_PREFIX.*)/{s/^/#IGNORE /g}' {} + \
		|| die "${LINENO}: failed to disable hardcoded settings"

	# NOTE Append some useful summary here
	cat >> CMakeLists.txt <<- _EOF_

		MESSAGE(STATUS "<<< Gentoo configuration >>>
		Build type: ${CMAKE_BUILD_TYPE}
		Install path: ${CMAKE_INSTALL_PREFIX}\n")
	_EOF_
}

# @FUNCTION: enable_cmake-utils_src_configure
# @DESCRIPTION:
# General function for configuring with cmake. Default behaviour is to start an
# out-of-source build.
enable_cmake-utils_src_configure() {
	debug-print-function ${FUNCNAME} "$@"

	_check_build_dir init

	# check if CMakeLists.txt exist and if no then die
	if [[ ! -e ${CMAKE_USE_DIR}/CMakeLists.txt ]] ; then
		eerror "I was unable to locate CMakeLists.txt under:"
		eerror "\"${CMAKE_USE_DIR}/CMakeLists.txt\""
		eerror "You should consider not inheriting the cmake eclass."
		die "FATAL: Unable to find CMakeLists.txt"
	fi

	# Remove dangerous things.
	_modify-cmakelists

	# Fix xdg collision with sandbox
	export XDG_CONFIG_HOME="${T}"

	# @SEE CMAKE_BUILD_TYPE
	if [[ ${CMAKE_BUILD_TYPE} = Gentoo ]]; then
		# Handle release builds
		if ! has debug ${IUSE//+} || ! use debug; then
			append-cppflags -DNDEBUG
		fi
	fi

	# Prepare Gentoo override rules (set valid compiler, append CPPFLAGS)
	local build_rules=${T}/gentoo_rules.cmake
	cat > "${build_rules}" <<- _EOF_
		SET (CMAKE_C_COMPILER $(type -P $(tc-getCC)) CACHE FILEPATH "C compiler" FORCE)
		SET (CMAKE_C_COMPILE_OBJECT "<CMAKE_C_COMPILER> <DEFINES> ${CPPFLAGS} <FLAGS> -o <OBJECT> -c <SOURCE>" CACHE STRING "C compile command" FORCE)
		SET (CMAKE_CXX_COMPILER $(type -P $(tc-getCXX)) CACHE FILEPATH "C++ compiler" FORCE)
		SET (CMAKE_CXX_COMPILE_OBJECT "<CMAKE_CXX_COMPILER> <DEFINES> ${CPPFLAGS} <FLAGS> -o <OBJECT> -c <SOURCE>" CACHE STRING "C++ compile command" FORCE)
	_EOF_

	if use prefix; then
		cat >> "${build_rules}" <<- _EOF_
			# in Prefix we need rpath and must ensure cmake gets our default linker path
			# right ... except for Darwin hosts
			IF (NOT APPLE)
			SET (CMAKE_SKIP_RPATH OFF CACHE BOOL "" FORCE)
			SET (CMAKE_PLATFORM_REQUIRED_RUNTIME_PATH "${EPREFIX}/usr/${CHOST}/lib/gcc;${EPREFIX}/usr/${CHOST}/lib;${EPREFIX}/usr/$(get_libdir);${EPREFIX}/$(get_libdir)"
			CACHE STRING "" FORCE)
			SET (CMAKE_BUILD_WITH_INSTALL_RPATH ON CACHE BOOL "" FORCE)
			ENDIF (NOT APPLE)
		_EOF_
	fi

	# Common configure parameters (invariants)
	local common_config=${T}/gentoo_common_config.cmake
	local libdir=$(get_libdir)
	cat > "${common_config}" <<- _EOF_
		SET (LIB_SUFFIX ${libdir/lib} CACHE STRING "library path suffix" FORCE)
	_EOF_
	[[ -n ${CMAKE_NO_COLOR} ]] && echo 'SET (CMAKE_COLOR_MAKEFILE OFF CACHE BOOL "pretty colors during make" FORCE)' >> "${common_config}"

	# Convert mycmakeargs to an array, for backwards compatibility
	# Make the array a local variable since <=portage-2.1.6.x does not
	# support global arrays (see bug #297255).
	if [[ $(declare -p mycmakeargs 2>&-) != "declare -a mycmakeargs="* ]]; then
		local mycmakeargs_local=(${mycmakeargs})
	else
		local mycmakeargs_local=("${mycmakeargs[@]}")
	fi

	has "${EAPI:-0}" 0 1 2 && ! use prefix && EPREFIX=

	# Common configure parameters (overridable)
	# NOTE CMAKE_BUILD_TYPE can be only overriden via CMAKE_BUILD_TYPE eclass variable
	# No -DCMAKE_BUILD_TYPE=xxx definitions will be in effect.
	local cmakeargs=(
		-C "${common_config}"
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}${PREFIX:-/usr}"
		"${mycmakeargs_local[@]}"
		-DCMAKE_BUILD_TYPE="${CMAKE_BUILD_TYPE}"
		-DCMAKE_INSTALL_DO_STRIP=OFF
		-DCMAKE_USER_MAKE_RULES_OVERRIDE="${build_rules}"
	)

	mkdir -p "${CMAKE_BUILD_DIR}"
	pushd "${CMAKE_BUILD_DIR}" > /dev/null
	debug-print "${LINENO} ${ECLASS} ${FUNCNAME}: mycmakeargs is ${mycmakeargs_local[*]}"
	echo cmake "${cmakeargs[@]}" "${CMAKE_USE_DIR}"
	cmake "${cmakeargs[@]}" "${CMAKE_USE_DIR}" || die "cmake failed"

	popd > /dev/null
}

# @FUNCTION: enable_cmake-utils_src_compile
# @DESCRIPTION:
# General function for compiling with cmake. Default behaviour is to check for
# EAPI and respectively to configure as well or just compile.
enable_cmake-utils_src_compile() {
	debug-print-function ${FUNCNAME} "$@"

	has src_configure ${CMAKE_EXPF} || cmake-utils_src_configure
	cmake-utils_src_make "$@"
}

# @FUNCTION: cmake-utils_src_make
# @DESCRIPTION:
# Function for building the package. Automatically detects the build type.
# All arguments are passed to emake
cmake-utils_src_make() {
	debug-print-function ${FUNCNAME} "$@"

	_check_build_dir
	pushd "${CMAKE_BUILD_DIR}" &> /dev/null
	# first check if Makefile exist otherwise die
	[[ -e Makefile ]] || die "Makefile not found. Error during configure stage."
	if [[ -n ${CMAKE_VERBOSE} ]]; then
		emake VERBOSE=1 "$@" || die "Make failed!"
	else
		emake "$@" || die "Make failed!"
	fi
	popd &> /dev/null
}

# @FUNCTION: enable_cmake-utils_src_install
# @DESCRIPTION:
# Function for installing the package. Automatically detects the build type.
enable_cmake-utils_src_install() {
	debug-print-function ${FUNCNAME} "$@"

	_check_build_dir
	pushd "${CMAKE_BUILD_DIR}" &> /dev/null
	emake install DESTDIR="${D}" || die "Make install failed"
	popd &> /dev/null

	# Manual document installation
	[[ -n "${DOCS}" ]] && { dodoc ${DOCS} || die "dodoc failed" ; }
	[[ -n "${HTML_DOCS}" ]] && { dohtml -r ${HTML_DOCS} || die "dohtml failed" ; }
}

# @FUNCTION: enable_cmake-utils_src_test
# @DESCRIPTION:
# Function for testing the package. Automatically detects the build type.
enable_cmake-utils_src_test() {
	debug-print-function ${FUNCNAME} "$@"

	_check_build_dir
	pushd "${CMAKE_BUILD_DIR}" &> /dev/null
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
	popd &> /dev/null
}

## Wrappers for calls bellow this line
# @FUNCTION: cmake-utils_src_configure
# @DESCRIPTION:
# Wrapper for detection if we want to run enable_ prefixed function with same name
# unconditionaly or only when some useflag is enabled.
cmake-utils_src_configure() {
	_execute_optionaly "src_configure"
}

# @FUNCTION: cmake-utils_src_compile
# @DESCRIPTION:
# Wrapper for detection if we want to run enable_ prefixed function with same name
# unconditionaly or only when some useflag is enabled.
cmake-utils_src_compile() {
	_execute_optionaly "src_compile"
}

# @FUNCTION: cmake-utils_src_install
# @DESCRIPTION:
# Wrapper for detection if we want to run enable_ prefixed function with same name
# unconditionaly or only when some useflag is enabled.
cmake-utils_src_install() {
	_execute_optionaly "src_install"
}

# @FUNCTION: cmake-utils_src_test
# @DESCRIPTION:
# Wrapper for detection if we want to run enable_ prefixed function with same name
# unconditionaly or only when some useflag is enabled.
cmake-utils_src_test() {
	_execute_optionaly "src_test"
}


_execute_optionaly() {
	local phase="$1"
	if [[ ${WANT_CMAKE} = always ]]; then
		enable_cmake-utils_${phase}
	else
		use ${WANT_CMAKE} && enable_cmake-utils_${phase}
	fi
}
