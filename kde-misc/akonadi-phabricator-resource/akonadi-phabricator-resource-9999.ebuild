# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_TEST="forceoptional"
inherit kde5

DESCRIPTION="Phabricator integration in Akonadi/KOrganizer"
HOMEPAGE="https://projects.kde.org/projects/playground/pim/akonadi-phabricator-resource"
LICENSE="GPL-2+"

KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kio)
	$(add_kdeapps_dep kasync)
	$(add_kdeapps_dep kcalcore)
	|| ( $(add_kdeapps_dep kdepimlibs) $(add_kdeapps_dep libakonadi) )
	dev-libs/libxslt
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
"
RDEPEND="${DEPEND}"
