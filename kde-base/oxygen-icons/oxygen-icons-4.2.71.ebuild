# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdesupport"
KMMODULE="oxygen-icons"
inherit kde4-meta

DESCRIPTION="Oxygen SVG icon theme."
HOMEPAGE="http://www.oxygen-icons.org/"
SRC_URI="http://dev.gentooexperimental.org/~alexxy/kde/${PV}/${P}.tar.lzma"

LICENSE="LGPL-3"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	!x11-themes/oxygen-icon
	!x11-themes/oxygen-icon-theme
"
