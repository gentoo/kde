# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_HANDBOOK="forceoptional"
inherit kde5

DESCRIPTION="KDE utility for management of partitions and file systems"
HOMEPAGE="https://www.kde.org/applications/system/kdepartitionmanager"

LICENSE="GPL-3"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kcrash)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kjobwidgets)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtwidgets)
	sys-apps/util-linux
	>=sys-libs/kpmcore-2.1.50:5=
"
RDEPEND="${DEPEND}
	$(add_plasma_dep kde-cli-tools kdesu 5.5.2)
	!sys-block/partitionmanager:0
"
