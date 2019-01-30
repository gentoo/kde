# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_TEST="true"
inherit kde5

DESCRIPTION="Library for accessing the features of social networking site vkontakte.ru"
HOMEPAGE="https://www.digikam.org/"

LICENSE="GPL-2+ || ( LGPL-2.1 LGPL-3 )"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdewebkit)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtnetwork)
	>=dev-qt/qtwebkit-5.212.0_pre20180120:5
	$(add_qt_dep qtwidgets)
"
RDEPEND="${DEPEND}"

# accessing network
RESTRICT+=" test"
