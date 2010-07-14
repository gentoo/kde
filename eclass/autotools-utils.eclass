# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# @ECLASS: autotools-utils.eclass
# @MAINTAINER:
# Maciej Mrozowski <reavertm@gentoo.org>
# @BLURB: common ebuild functions for autotools-based packages
# @DESCRIPTION:
# autotools-utils.eclass is autotools.eclass(5) and base.eclass(5) wrapper
# providing all inherited features along with econf arguments as Bash array,
# out of source build with overridable build dir location, static archives
# handling, libtool files removal, enable/disable debug handling.
#
# @EXAMPLE:
# Typical ebuild using autotools-utils.eclass:
#
# @CODE
# EAPI="2"
#
# inherit autotools-utils
#
# DESCRIPTION="Foo bar application"
# HOMEPAGE="http://example.org/foo/"
# SRC_URI="mirror://sourceforge/foo/${P}.tar.bz2"
#
# LICENSE="LGPL-2.1"
# KEYWORDS=""
# SLOT="0"
# IUSE="debug doc examples qt4 static-libs tiff"
#
# CDEPEND="
# 	media-libs/libpng:0
# 	qt4? (
# 		x11-libs/qt-core:4
# 		x11-libs/qt-gui:4
# 	)
# 	tiff? ( media-libs/tiff:0 )
# "
# RDEPEND="${CDEPEND}
# 	!media-gfx/bar
# "
# DEPEND="${CDEPEND}
# 	doc? ( app-doc/doxygen )
# "
#
# # bug 123456
# AUTOTOOLS_IN_SOURCE_BUILD=1
#
# DOCS=(AUTHORS ChangeLog README "Read me.txt" TODO)
#
# PATCHES=(
# 	"${FILESDIR}/${P}-gcc44.patch" # bug 123458
# 	"${FILESDIR}/${P}-as-needed.patch"
# 	"${FILESDIR}/${P}-unbundle_libpng.patch"
# )
#
# src_configure() {
# 	myeconfargs=(
# 		$(use_with qt4)
# 		$(use_enable threads multithreading)
# 		$(use_with tiff)
# 	)
# 	autotools-utils_src_configure
# }
#
# src_compile() {
# 	autotools-utils_src_compile
# 	use doc && autotools-utils_src_compile docs
# }
#
# src_install() {
# 	use doc && HTML_DOCS=("${AUTOTOOLS_BUILD_DIR}/apidocs/html/")
# 	autotools-utils_src_install
# 	if use examples; then
# 		dobin "${AUTOTOOLS_BUILD_DIR}"/foo_example{1,2,3} \\
# 			|| die 'dobin examples failed'
# 	fi
# }
#
# @CODE

# Keep variable names synced with cmake-utils and the other way around!

case ${EAPI:-0} in
	2|3|4) ;;
	*) DEPEND="EAPI-TOO-OLD" ;;
esac

inherit autotools base

EXPORT_FUNCTIONS src_prepare src_configure src_compile src_install src_test

# @ECLASS-VARIABLE: AUTOTOOLS_BUILD_DIR
# @DESCRIPTION:
# Build directory, location where all autotools generated files should be
# placed. For out of source builds it defaults to ${WORKDIR}/${P}_build.

# @ECLASS-VARIABLE: AUTOTOOLS_IN_SOURCE_BUILD
# @DESCRIPTION:
# Set to enable in-source build.

# @ECLASS-VARIABLE: ECONF_SOURCE
# @DESCRIPTION:
# Specify location of autotools' configure script. By default it uses ${S}.

# @ECLASS-VARIABLE: myeconfargs
# @DESCRIPTION:
# Optional econf arguments as Bash array. Should be defined before calling src_configure.
# @CODE
# src_configure() {
# 	myeconfargs=(
# 		--disable-readline
# 		--with-confdir="/etc/nasty foo confdir/"
# 		$(use_enable debug cnddebug)
# 		$(use_enable threads multithreading)
# 	)
# 	autotools-utils_src_configure
# }
# @CODE

# Determine using IN or OUT source build
_check_build_dir() {
	: ${ECONF_SOURCE:=${S}}
	if [[ -n ${AUTOTOOLS_IN_SOURCE_BUILD} ]]; then
		AUTOTOOLS_BUILD_DIR="${ECONF_SOURCE}"
	else
		: ${AUTOTOOLS_BUILD_DIR:=${WORKDIR}/${P}_build}
	fi
	echo ">>> Working in BUILD_DIR: \"$AUTOTOOLS_BUILD_DIR\""
}

# @FUNCTION: remove_libtool_files
# @USAGE: [all|none]
# @DESCRIPTION:
# Determines useless libtool files (.la) and libtool static archives (.a)
# and removes them from installation image.
# To unconditionally remove all libtool files, pass 'all' as argument.
# To leave all libtool files alone, pass 'none' as argument.
# Unnecessary static archives are removed in any case.
#
# In most cases it's not necessary to manually invoke this function.
# See autotools-utils_src_install for reference.
remove_libtool_files() {
	debug-print-function ${FUNCNAME} "$@"

	local f
	for f in $(find "${D}" -type f -name '*.la'); do
		# Keep only .la files with shouldnotlink=yes - likely plugins
		local shouldnotlink=$(sed -ne '/^shouldnotlink=yes$/p' "${f}")
		if [[  "$1" == 'all' || -z ${shouldnotlink} ]]; then
			if [[ "$1" != 'none' ]]; then
				echo "Removing unnecessary ${f}"
				rm -f "${f}"
			fi
		fi
		# Remove static libs we're not supposed to link against
		if [[ -n ${shouldnotlink} ]]; then
			local remove=${f/%.la/.a}
			[[ "${f}" != "${remove}" ]] || die 'regex sanity check failed'
			echo "Removing unnecessary ${remove}"
			rm -f "${remove}"
		fi
	done
}

# @FUNCTION: autotools-utils_src_prepare
# @DESCRIPTION:
# The src_prepare function.
#
# Supporting PATCHES array and user patches. See base.eclass(5) for reference.
autotools-utils_src_prepare() {
	debug-print-function ${FUNCNAME} "$@"

	base_src_prepare
}

# @FUNCTION: autotools-utils_src_configure
# @DESCRIPTION:
# The src_configure function. For out of source build it creates build
# directory and runs econf there. Configuration parameters defined
# in myeconfargs are passed here to econf. Additionally following USE
# flags are known:
#
# IUSE="debug" passes --disable-debug/--enable-debug to econf respectively.
#
# IUSE="static-libs" passes --enable-shared and either --disable-static/--enable-static
# to econf respectively.
autotools-utils_src_configure() {
	debug-print-function ${FUNCNAME} "$@"

	# Common args
	local econfargs=()

	# Handle debug found in IUSE
	if has debug ${IUSE//+}; then
		econfargs+=($(use_enable debug))
	fi

	# Handle static-libs found in IUSE, disable them by default
	if has static-libs ${IUSE//+}; then
		econfargs+=(
			--enable-shared
			$(use_enable static-libs static)
		)
	fi

	# Append user args
	econfargs+=(${myeconfargs[@]})

	_check_build_dir
	mkdir -p "${AUTOTOOLS_BUILD_DIR}" || die "mkdir '${AUTOTOOLS_BUILD_DIR}' failed"
	pushd "${AUTOTOOLS_BUILD_DIR}" > /dev/null
	base_src_configure "${econfargs[@]}"
	popd > /dev/null
}

# @FUNCTION: autotools-utils_src_compile
# @DESCRIPTION:
# The autotools src_compile function, invokes emake in specified AUTOTOOLS_BUILD_DIR.
autotools-utils_src_compile() {
	debug-print-function ${FUNCNAME} "$@"

	_check_build_dir
	pushd "${AUTOTOOLS_BUILD_DIR}" > /dev/null
	base_src_compile "$@"
	popd > /dev/null
}

# @FUNCTION: autotools-utils_src_install
# @DESCRIPTION:
# The autotools src_install function. Runs emake install, unconditionally removes
# unnecessary static libs (based on shouldnotlink libtool property)
# and removes libtool files when static-libs USE flag is defined and unset.
#
# DOCS and HTML_DOCS arrays are supported. See base.eclass(5) for reference.
autotools-utils_src_install() {
	debug-print-function ${FUNCNAME} "$@"

	_check_build_dir
	pushd "${AUTOTOOLS_BUILD_DIR}" > /dev/null
	base_src_install
	popd > /dev/null

	# Remove libtool files and unnecessary static libs
	local args
	has static-libs ${IUSE//+} && ! use static-libs || args='none'
	remove_libtool_files ${args}
}

# @FUNCTION: autotools-utils_src_test
# @DESCRIPTION:
# The autotools src_test function. Runs emake check in build directory.
autotools-utils_src_test() {
	debug-print-function ${FUNCNAME} "$@"

	_check_build_dir
	pushd "${AUTOTOOLS_BUILD_DIR}" > /dev/null
	# Run default src_test as defined in ebuild.sh
	default_src_test
	popd > /dev/null
}
