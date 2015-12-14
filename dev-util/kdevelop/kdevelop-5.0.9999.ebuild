# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGIT_BRANCH="5.0"
KDE_HANDBOOK="forceoptional"
VIRTUALX_REQUIRED="test"
inherit kde5

DESCRIPTION="Integrated Development Environment, supporting KDE/Qt, C/C++ and much more"
LICENSE="GPL-2 LGPL-2"
IUSE="+clang +cmake +cxx debug +ninja +plasma +qmake qthelp"
KEYWORDS=""

# TODO: disabled upstream
# okteta? ( $(add_kdeapps_dep okteta) )
DEPEND="
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdeclarative)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kitemviews)
	$(add_frameworks_dep kjobwidgets)
	$(add_frameworks_dep kparts)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep ktexteditor)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep threadweaver)
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtscript:5
	dev-qt/qtwebkit:5
	dev-qt/qtwidgets:5
	>=dev-util/kdevplatform-${PV}:5
	cxx? ( clang? ( >=sys-devel/clang-3.5.0 ) )
	plasma? (
		$(add_frameworks_dep krunner)
		$(add_frameworks_dep plasma)
	)
	qmake? ( dev-util/kdevelop-pg-qt:5 )
	qthelp? ( dev-qt/qthelp:5 )
"
RDEPEND="${DEPEND}
	$(add_kdeapps_dep kapptemplate)
	$(add_kdeapps_dep kio-extras)
	cxx? ( >=sys-devel/gdb-7.0[python] )
	ninja? ( dev-util/ninja )
	!dev-util/kdevelop:4
	!dev-util/kdevelop-qmake
	!dev-util/kdevelop-qmljs
	cxx? ( clang? ( !dev-util/kdevelop-clang ) )
"

RESTRICT="test"
# see bug 366471

PATCHES=( "${FILESDIR}/${PN}-ninja-optional.patch" )

src_configure() {
	local mycmakeargs=(
		-DLEGACY_CPP_SUPPORT=$(usex !clang)
		$(cmake-utils_use_build cmake)
		$(cmake-utils_use_build cmake cmakebuilder)
		$(cmake-utils_use_build ninja ninjabuilder)
		$(cmake-utils_use_build cxx clang)
		$(cmake-utils_use_build cxx cpp)
		$(cmake-utils_use_build qthelp)
		$(cmake-utils_use_find_package plasma KF5Plasma)
		$(cmake-utils_use_find_package qmake KDevelop-PG-Qt)
	)

	kde5_src_configure
}

src_install() {
	kde5_src_install
	# fix file collision with <kde-apps/kapptemplate-15.12.50
	rm "${ED}"usr/share/kdevappwizard/templates/qmake_qt4guiapp.tar.bz2 || die
}
