# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base
DESCRIPTION="Data server for Plasma Active"
HOMEPAGE="http://www.kde.org/"
SRC_URI="mirror://kde/stable/active/3.0/src/${P}.tar.xz"

LICENSE="GPL-2+ LGPL-2+ LGPL-2.1+"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-libs/shared-desktop-ontologies
	dev-libs/soprano
	dev-qt/qt-mobility
	$(add_kdebase_dep nepomuk)
"
RDEPEND="${DEPEND}"
