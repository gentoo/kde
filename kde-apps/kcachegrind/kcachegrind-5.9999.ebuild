# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGIT_BRANCH="frameworks"
KDE_HANDBOOK="true"
inherit kde5

DESCRIPTION="KDE Frontend for Cachegrind"
HOMEPAGE="https://www.kde.org/applications/development/kcachegrind
http://kcachegrind.sourceforge.net"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
"
RDEPEND="${DEPEND}
	media-gfx/graphviz
"
