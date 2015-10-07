# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_HANDBOOK=true
inherit kde5

DESCRIPTION="Small utility which bothers you at certain intervals"
HOMEPAGE="https://userbase.kde.org/RSIBreak"

LICENSE="GPL-2+ FDL-1.2"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kdoctools)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kidletime)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep knotifyconfig)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep kwindowsystem)
"
RDEPEND="${DEPEND}
	!kde-misc/rsibreak:4
"
