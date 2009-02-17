# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="A KDE4 Plasma Applet. It's calculator, consisting of one lineedit widget"
HOMEPAGE="http://www.kde-look.org/content/show.php/One-Line+Calculator?content=89524"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/89524-${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_prepare()
{
	epatch "${FILESDIR}/cmake_fix_for_kde-4_2.patch"
}

