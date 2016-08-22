# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

EGIT_BRANCH="5.0"
KDE_HANDBOOK="forceoptional"
KDE_TEST="true"
VIRTUALX_REQUIRED="test"
inherit kde5

DESCRIPTION="Integrated Development Environment, supporting KF5/Qt, C/C++ and much more"
LICENSE="GPL-2 LGPL-2"
IUSE="+clang +cmake +gdbui +ninja okteta +plasma +qmake qthelp"
[[ ${KDE_BUILD_TYPE} = release ]] && KEYWORDS="~amd64 ~x86"

DEPEND="
	$(add_frameworks_dep kcmutils)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kcrash)
	$(add_frameworks_dep kdeclarative)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kitemmodels)
	$(add_frameworks_dep kitemviews)
	$(add_frameworks_dep kjobwidgets)
	$(add_frameworks_dep knewstuff)
	$(add_frameworks_dep knotifyconfig)
	$(add_frameworks_dep kparts)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep ktexteditor)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep threadweaver)
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtnetwork)
	$(add_qt_dep qtwebkit)
	$(add_qt_dep qtwidgets)
	>=dev-util/kdevplatform-${PV}:5
	x11-misc/shared-mime-info
	clang? ( >=sys-devel/clang-3.5.0 )
	gdbui? ( $(add_plasma_dep ksysguard) )
	okteta? ( $(add_kdeapps_dep okteta) )
	plasma? (
		$(add_frameworks_dep krunner)
		$(add_frameworks_dep plasma)
	)
	qmake? ( dev-util/kdevelop-pg-qt:5 )
	qthelp? ( $(add_qt_dep qthelp) )
"
RDEPEND="${DEPEND}
	$(add_kdeapps_dep kapptemplate)
	$(add_kdeapps_dep kio-extras)
	>=sys-devel/gdb-7.0[python]
	ninja? ( dev-util/ninja )
	!dev-util/kdevelop:4
	!dev-util/kdevelop-clang
	!dev-util/kdevelop-qmake
	!dev-util/kdevelop-qmljs
	!<kde-apps/kapptemplate-16.04.0
"

RESTRICT+=" test"
# see bug 366471

PATCHES=(
	"${FILESDIR}/${PN}-ninja-optional.patch"
	"${FILESDIR}/${P}-fix-cpp.patch"
)

src_configure() {
	local mycmakeargs=(
		-DLEGACY_CPP_SUPPORT=$(usex !clang)
		-DBUILD_cmake=$(usex cmake)
		-DBUILD_cmakebuilder=$(usex cmake)
		$(cmake-utils_use_find_package gdbui KF5SysGuard)
		-DBUILD_executeplasmoid=$(usex plasma)
		$(cmake-utils_use_find_package plasma KF5Plasma)
		-DBUILD_ninjabuilder=$(usex ninja)
		$(cmake-utils_use_find_package okteta OktetaKastenControllers)
		$(cmake-utils_use_find_package qmake KDevelop-PG-Qt)
		-DBUILD_qthelp=$(usex qthelp)
	)

	kde5_src_configure
}
