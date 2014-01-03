# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base
DESCRIPTION="An interface to build relations between Plasma Active applications"
HOMEPAGE="http://www.kde.org/"
SRC_URI="mirror://kde/stable/active/4.0/src/${P}.tar.xz"

LICENSE="LGPL-2 LGPL-2.1"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-libs/soprano
	$(add_kdebase_dep kactivities)
	$(add_kdebase_dep nepomuk)
"
RDEPEND="${DEPEND}"

DOCS=( "docs/share_like_connect.odp" )
