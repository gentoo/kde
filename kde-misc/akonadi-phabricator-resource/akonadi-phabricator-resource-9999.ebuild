# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

KDE_TEST="forceoptional"
inherit kde5

DESCRIPTION="Phabricator integration in Akonadi/KOrganizer"
HOMEPAGE="https://cgit.kde.org/akonadi-phabricator-resource.git"
LICENSE="GPL-2+"

KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kio)
	$(add_kdeapps_dep akonadi)
	$(add_kdeapps_dep kcalcore)
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtnetwork)
	dev-libs/kasync
	dev-libs/libxslt
"
RDEPEND="${DEPEND}"
