# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit cmake-utils

DESCRIPTION="Oxygen SVG icon theme."
HOMEPAGE="http://www.oxygen-icons.org/"
SRC_URI="http://dev.gentooexperimental.org/~alexxy/kde/${PV}/${P}.tar.lzma"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	!<=kde-base/kdebase-data-4.2.66[-kdeprefix]
	!x11-themes/oxygen-icon-theme
"
