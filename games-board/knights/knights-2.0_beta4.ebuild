# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KDE_MINIMAL=4.4
inherit kde4-base

DESCRIPTION="A simple chess board for KDE"
HOMEPAGE="http://kde-apps.org/content/show.php/Knights?content=122046"
SRC_URI="http://kde-apps.org/CONTENT/content-files/122046-${PN}_${PV/_}_source.tar.gz"

LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND=">=kde-base/libkdegames-${KDE_MINIMAL}"

S=${WORKDIR}/${PN/k/K}

src_prepare() {
	echo "Categories=Game;BoardGame;" >> src/${PN}.desktop
	kde4-base_src_prepare
}
