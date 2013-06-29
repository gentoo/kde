# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

DESCRIPTION="KDE plasmoid to switch between KWin's compositing and traditional mode"
HOMEPAGE="http://www.kde-look.org/content/show.php/Toggle-Compositing?content=78299"
SRC_URI="http://ivplasma.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

RDEPEND="
	!kde-plasmoids/toggle-compositing
	$(add_kdebase_dep plasma-workspace)
"

S="${WORKDIR}/${PN}"
