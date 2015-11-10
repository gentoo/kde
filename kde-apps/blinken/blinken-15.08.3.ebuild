# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_HANDBOOK="true"
KDE_PUNT_BOGUS_DEPS="true"
inherit kde5

DESCRIPTION="KDE version of the Simon Says game"
HOMEPAGE="https://www.kde.org/applications/education/blinken
https://edu.kde.org/blinken"
KEYWORDS=" ~amd64 ~x86"
IUSE=""

DEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kguiaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kxmlgui)
	dev-qt/qtgui:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	media-libs/phonon[qt5]
"
RDEPEND="${DEPEND}"

src_install() {
	kde5_src_install

	rm "${D}"/usr/share/${PN}/README.packagers
}
