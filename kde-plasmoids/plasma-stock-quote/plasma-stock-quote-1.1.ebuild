# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="A KDE4 Plasma Applet. This plasmoid monitors stock exchange."
HOMEPAGE="http://www.kde-look.org/content/show.php/Stock+Quote?content=90695"
SRC_URI="http://kde-look.org/CONTENT/content-files/90695-${PN//-/_}-${PV}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="!kde-misc/plasmoids
		kde-base/libplasma"

S=${WORKDIR}/${PN//-/_}-${PV}
