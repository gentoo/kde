# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGIT_BRANCH="frameworks"
FRAMEWORKS_MINIMAL="5.16.0"
KDE_DOXYGEN="true"
KDE_TEST="true"
KMNAME="kde-baseapps"
VIRTUALX_REQUIRED="test"
inherit kde5

DESCRIPTION="The embeddable part of konqueror"
KEYWORDS=""
IUSE="+minimal"

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
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtwidgets)
	$(add_qt_dep qtxml)
	sys-libs/zlib
"
RDEPEND="${DEPEND}"

RESTRICT="test"

S=${S}/lib/konq

src_install() {
	kde5_src_install

	if use minimal; then
		if [[ -e "${ED}"usr/share/kservicetypes5/konqpopupmenuplugin.desktop ]] ; then
			rm "${ED}"usr/share/kservicetypes5/konqpopupmenuplugin.desktop || die
		fi
	fi
}
