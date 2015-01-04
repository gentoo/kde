# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VIRTUALX_REQUIRED="test"
inherit kde5

DESCRIPTION="Integrated Development Environment for Unix, supporting KDE/Qt, C/C++ and many other languages"
LICENSE="GPL-2 LGPL-2"
IUSE="+cmake +cxx debug qthelp runner"
KEYWORDS=""

# TODO: disabled upstream
# okteta? ( $(add_kdebase_dep okteta) )
DEPEND="
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kitemviews)
	$(add_frameworks_dep kparts)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep ktexteditor)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep plasma)
	$(add_frameworks_dep threadweaver)
	dev-util/kdevplatform:5
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtscript:5
	dev-qt/qtwebkit:5
	dev-qt/qtwidgets:5
	qthelp? ( dev-qt/qthelp:5 )
	runner? ( $(add_frameworks_dep krunner) )
"
RDEPEND="${DEPEND}
	$(add_kdeapps_dep kapptemplate)
	cxx? ( >=sys-devel/gdb-7.0[python] )
	!dev-util/kdevelop:4
"

RESTRICT="test"
# see bug 366471

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_build cmake)
		$(cmake-utils_use_build cmake cmakebuilder)
		$(cmake-utils_use_build cxx cpp)
		$(cmake-utils_use_build qthelp)
		$(cmake-utils_use_find_package runner KF5Runner)
	)

	kde5_src_configure
}
