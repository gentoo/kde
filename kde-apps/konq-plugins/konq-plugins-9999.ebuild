# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KMNAME="kde-baseapps"
KDE_TEST="true"
inherit kde5

DESCRIPTION="Various plugins for konqueror"
KEYWORDS=""
IUSE="speech tidy"

DEPEND="
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep kcrash)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep khtml)
	$(add_frameworks_dep kparts)
	$(add_frameworks_dep kdesu)
	$(add_kdeapps_dep libkonq)
	$(add_qt_dep qtwidgets)
	speech? ( $(add_qt_dep qtspeech) )
	tidy? (
		$(add_frameworks_dep kiconthemes)
		$(add_frameworks_dep kwidgetsaddons)
		app-text/htmltidy
	)
"
RDEPEND="${DEPEND}
	$(add_kdeapps_dep konqueror)
	$(add_plasma_dep kde-cli-tools)
"

S="${S}/${PN}"

PATCHES=( "${FILESDIR}/${PN}-ecmmarkastest.patch" )

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package speech Qt5TextToSpeech)
		$(cmake-utils_use_find_package tidy LibTidy)
	)
	kde5_src_configure
}
