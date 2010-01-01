# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

MY_PN="iHateTheCashew"

DESCRIPTION="KDE4 plasmoid. Removes the \"hand\" in upper right corner of the screen"
HOMEPAGE="http://www.kde-look.org/content/show.php/I+HATE+the+Cashew?content=91009"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/91009-${MY_PN}-4.2.tbz"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug"

RDEPEND="
	!kde-plasmoids/iHateTheCashew
	>=kde-base/plasma-workspace-${KDE_MINIMAL}
"

S="${WORKDIR}/${MY_PN}"
