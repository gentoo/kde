# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

MY_P="${PN}/${PN}-0.1"

DESCRIPTION="A KDE4 Plasma Applet. This plasmoid is to remind us to take our eyes off the screen"
HOMEPAGE="http://www.kde-look.org/content/show.php/Eyesaver?content=89989"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/89989-${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${MY_P}"

src_prepare()
{
	epatch "${FILESDIR}/cmake_fix_for_kde-4_2.patch"
}

