# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit kde4-base

MY_PN="onlinecalc"

DESCRIPTION="KDE4 plasmoid. Calculator consisting of a one line edit widget"
HOMEPAGE="http://www.kde-look.org/content/show.php/One-Line+Calculator?content=89524"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/89524-${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

RDEPEND="
	!kde-plasmoids/onelinecalc
	$(add_kdebase_dep plasma-workspace)
"

S=${WORKDIR}/${MY_PN}
