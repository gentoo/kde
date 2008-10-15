# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

NEED_KDE=":4.1"
inherit kde4-base

DESCRIPTION="A KDE4 Plasma Applet. This plasmoid shows TV stations program in Greek."
KEYWORDS="~amd64 ~x86"
HOMEPAGE="http://www.kde-look.org/content/show.php/Eyesaver?content=75728"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/75728-${PN}.tar.gz"

LICENSE="GPL-3"

SLOT="4.1"
IUSE=""

DEPEND="!kde-misc/plasmoids
		kde-base/libplasma"

S="${WORKDIR}/${PN}/${PN}"
