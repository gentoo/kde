# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="extragear/sdk"
inherit kde4-base

if [[ ${PV} == *9999* ]]; then
	KDEVPLATFORM_PV="9999"
else
	inherit versionator
	KDEVPLATFORM_PV="$(($(get_major_version)-3)).$(get_after_major_version)"
fi
DESCRIPTION="Integrated Development Environment for Unix, supporting KDE/Qt, C/C++ and many other languages."
HOMEPAGE="http://www.kdevelop.org/"
[[ ${PV} != *9999* ]] && SRC_URI="mirror://kde/unstable/${PN}/${PV}/src/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
KEYWORDS=""
SLOT="4"
IUSE="+cmake +cxx debug +qmake qthelp"

DEPEND="
	>=dev-util/kdevplatform-${KDEVPLATFORM_PV}
	>=kde-base/ksysguard-${KDE_MINIMAL}
	>=kde-base/libkworkspace-${KDE_MINIMAL}
	qthelp? ( >=x11-libs/qt-assistant-4.4:4 )
"
RDEPEND="${DEPEND}
	>=kde-base/kapptemplate-${KDE_MINIMAL}
"

src_prepare() {
	kde4-base_src_prepare

	# Remove this and the ksysguard dep after libprocessui moved into kdelibs
	sed -i -e 's/${KDE4WORKSPACE_PROCESSUI_LIBS}/processui/g' \
		debuggers/gdb/CMakeLists.txt \
		|| die "Failed to patch CMake files"
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_build cmake)
		$(cmake-utils_use_build cmake cmakebuilder)
		$(cmake-utils_use_build qmake)
		$(cmake-utils_use_build qmake qmakebuilder)
		$(cmake-utils_use_build qmake qmake_parser)
		$(cmake-utils_use_build cxx cpp)
		$(cmake-utils_use_build qthelp)
	)

	kde4-base_src_configure
}

src_install() {
	kde4-base_src_install

	rm "${D}/${PREFIX}"/share/apps/kdevappwizard/templates/qmake_qt4guiapp.tar.bz2
	rm "${D}/${PREFIX}"/share/icons/hicolor/22x22/actions/output_win.png
}

pkg_postinst() {
	kde4-base_pkg_postinst

	echo
	elog "For extra functionality you should look at following packages:"
	elog "dev-util/valgrind          allows you to do memory leak check."
	elog ">=sys-devel/gdb-7.0        (RECOMMENDED) required by debugger frontend."
	echo
}
