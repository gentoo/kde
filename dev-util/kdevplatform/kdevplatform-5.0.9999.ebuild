# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

# TODO tests hang + fail
# KDE_TEST="true"
# VIRTUALDBUS_TEST="true"
# VIRTUALX_REQUIRED="test"
EGIT_BRANCH="5.0"
RESTRICT="test"
KDE_DOXYGEN="true"
KDEBASE="kdevelop"
inherit kde5

DESCRIPTION="KDE development support libraries and apps"
IUSE="classbrowser cvs konsole reviewboard subversion +templates"
KEYWORDS=""

COMMON_DEPEND="
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep kbookmarks)
	$(add_frameworks_dep kcmutils)
	$(add_frameworks_dep kcodecs)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdeclarative)
	$(add_frameworks_dep kguiaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kitemmodels)
	$(add_frameworks_dep kitemviews)
	$(add_frameworks_dep kjobwidgets)
	$(add_frameworks_dep knewstuff)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep knotifyconfig)
	$(add_frameworks_dep kparts)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep ktexteditor)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep sonnet)
	$(add_frameworks_dep threadweaver)
	$(add_kdeapps_dep libkomparediff2)
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtdeclarative 'widgets')
	$(add_qt_dep qtgui)
	$(add_qt_dep qtnetwork)
	$(add_qt_dep qtwebkit)
	$(add_qt_dep qtwidgets)
	$(add_qt_dep qtxml)
	subversion? (
		dev-libs/apr:1
		dev-libs/apr-util:1
		dev-vcs/subversion
	)
	templates? ( dev-libs/grantlee:5 )
"
DEPEND="${COMMON_DEPEND}
	dev-libs/boost
	$(add_qt_dep qtconcurrent)
	$(add_qt_dep qttest)
"
RDEPEND="${COMMON_DEPEND}
	cvs? ( dev-vcs/cvs )
	konsole? ( $(add_kdeapps_dep konsole) )
	!dev-util/kdevelop:4
	!dev-util/kdevplatform:4
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_classbrowser=$(usex classbrowser)
		-DBUILD_cvs=$(usex cvs)
		-DBUILD_konsole=$(usex konsole)
		-DBUILD_reviewboard=$(usex reviewboard)
		$(cmake-utils_use_find_package subversion SubversionLibrary)
		$(cmake-utils_use_find_package templates Grantlee5)
	)

	kde5_src_configure
}
