# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="A KDE4 Plasma Applet which reimplements the quicklaunch applet present in kde3.5"
HOMEPAGE="http://www.kde-look.org/content/show.php/QuickLauncher+Applet?content=78061"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/78061-plasma-applet-${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="!kde-misc/plasmoids
		kde-base/libplasma"

S="${WORKDIR}/plasma-applet-${P}/src"
