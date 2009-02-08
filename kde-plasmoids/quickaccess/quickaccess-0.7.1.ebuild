# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KDE_MINIMAL="4.2"

inherit kde4-base

MY_P="${P}_kde42"

DESCRIPTION="A KDE4 Plasma Applet designed for the panel to have quick access to the most used folders"
HOMEPAGE="http://kde-look.org/content/show.php/QuickAccess?content=84128"
SRC_URI="http://kde-look.org/CONTENT/content-files/98521-${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${MY_P}"
