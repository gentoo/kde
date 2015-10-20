# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_TEST="true"
inherit kde5

DESCRIPTION="Library for accessing the features of social networking site vkontakte.ru"
HOMEPAGE="http://www.digikam.org/"

LICENSE="GPL-2"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep kdewebkit)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kwidgetsaddons)
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwebkit:5
	dev-qt/qtwidgets:5
	>=dev-libs/qjson-0.7.0
"
RDEPEND="${DEPEND}"

# accessing network
RESTRICT="test"
