# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_BRANCH="kf5"
KDE_TEST="true"
inherit kde5

DESCRIPTION="CDDB enabled audio CD player based on KDE Frameworks"
HOMEPAGE="https://kde.org/applications/multimedia/kscd/"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep solid)
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtsvg)
	$(add_qt_dep qtwidgets)
	media-libs/libdiscid
	media-libs/musicbrainz:5
	media-libs/phonon[qt5(+)]
"
RDEPEND="${DEPEND}"
