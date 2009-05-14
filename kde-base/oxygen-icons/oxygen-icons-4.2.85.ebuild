# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdesupport"
KDE_REQUIRED="never"
inherit kde4-base

DESCRIPTION="Oxygen SVG icon theme."
HOMEPAGE="http://www.oxygen-icons.org/"
SRC_URI="mirror://kde/unstable/${PV}/src/${P}.tar.bz2"

LICENSE="LGPL-3"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	!x11-themes/oxygen-icons
	!x11-themes/oxygen-icon-theme
	!<=kde-base/kdepim-icons-4.2.71:4.3[kdeprefix=]
"
