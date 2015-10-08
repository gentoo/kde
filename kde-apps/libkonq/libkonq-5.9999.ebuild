# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGIT_BRANCH="frameworks"
KDE_DOXYGEN="true"
KDE_TEST="true"
KMNAME="kde-baseapps"
VIRTUALX_REQUIRED="test"
inherit kde5

DESCRIPTION="The embeddable part of konqueror"
KEYWORDS=""
IUSE="minimal"

DEPEND="
	$(add_frameworks_dep kbookmarks)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kjobwidgets)
	$(add_frameworks_dep kparts)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	sys-libs/zlib
"
RDEPEND="${DEPEND}"

RESTRICT="test"

S=${S}/lib/konq

src_install() {
	kde5_src_install

	if use minimal; then
		rm "${D}"/usr/share/templates/{Directory,HTMLFile,TextFile}.desktop || die
		rm "${D}"/usr/share/templates/{linkPath,linkProgram,linkURL}.desktop || die
		rm "${D}"/usr/share/templates/.source/{Program,URL}.desktop || die
		rm "${D}"/usr/share/templates/.source/{HTMLFile.html,TextFile.txt} || die
	fi
}
