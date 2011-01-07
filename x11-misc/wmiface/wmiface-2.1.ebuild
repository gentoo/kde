# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit cmake-utils

DESCRIPTION="Command line tool allowing user scripting of the running window manager"
HOMEPAGE="http://kde-apps.org/content/show.php/WMIface?content=40425"
SRC_URI="http://ktown.kde.org/~seli/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	x11-libs/qt-core
	x11-libs/libX11
"
RDEPEND="${DEPEND}"
