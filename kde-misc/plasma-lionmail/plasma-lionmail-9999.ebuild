# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit kde4-base

DESCRIPTION="A Plasma widget displaying new and important email"
HOMEPAGE="http://www.kde.org http://www.vizzzion.org"

LICENSE="GPL-2 LGPL-2"
SLOT="4"
KEYWORDS=""
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kdelibs)
	$(add_kdebase_dep kdepimlibs)
	app-office/akonadi-server
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	dev-qt/qtwebkit:4
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kdepim-runtime)
"
