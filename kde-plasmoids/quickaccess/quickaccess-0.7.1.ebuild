# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="A KDE4 Plasma Applet designed for the panel to have quick access to the most used folders"
HOMEPAGE="http://kde-look.org/content/show.php/QuickAccess?content=84128"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/84128-${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="!kde-misc/plasmoids
		kde-base/libplasma"
