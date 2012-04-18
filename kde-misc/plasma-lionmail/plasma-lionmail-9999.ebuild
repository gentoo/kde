# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_SCM="git"
inherit kde4-base

DESCRIPTION="A Plasma widget displaying new and important email"
HOMEPAGE="http://www.kde.org http://www.vizzzion.org"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
		kde-base/kdepimlibs
		x11-libs/qt-webkit
		app-office/akonadi-server
"
RDEPEND="${DEPEND}
		kde-base/kdepim-runtime
"
