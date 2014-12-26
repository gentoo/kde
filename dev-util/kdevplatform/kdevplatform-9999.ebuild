# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

# TODO tests hang + fail
# KDE_TEST="true"
# VIRTUALDBUS_TEST="true"
# VIRTUALX_REQUIRED="test"
RESTRICT="test"
KMNAME="kdevelop"
EGIT_REPONAME="${PN}"
inherit kde5

DESCRIPTION="KDE development support libraries and apps"
IUSE="classbrowser cvs konsole reviewboard"
KEYWORDS=""

# TODO features disabled by upstream, maybe more
# Subversion integration: subversion? (dev-libs/apr dev-libs/apr-util dev-vcs/subversion )
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
	$(add_frameworks_dep kdelibs4support)
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
	dev-libs/grantlee:5
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtquick1:5
	dev-qt/qtwebkit:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
"
DEPEND="${COMMON_DEPEND}
	dev-qt/qttest:5
	classbrowser? ( dev-libs/boost )
"
RDEPEND="${COMMON_DEPEND}
	cvs? ( dev-vcs/cvs )
	konsole? ( $(add_kdeapps_dep konsole) )
	!dev-util/kdevelop:4
	!dev-util/kdevplatform:4
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_build classbrowser)
		$(cmake-utils_use_build cvs)
		$(cmake-utils_use_build konsole)
		$(cmake-utils_use_build reviewboard)
	)

	kde5_src_configure
}
