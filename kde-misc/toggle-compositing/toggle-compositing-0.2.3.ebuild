# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

MY_P="${PN}"

DESCRIPTION="KDE4 plasmoid. Switch between KWin's compositing and traditional mode with ease."
HOMEPAGE="http://www.kde-look.org/content/show.php/Toggle-Compositing?content=78299"
SRC_URI="http://ivplasma.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=kde-base/plasma-workspace-${KDE_MINIMAL}"
RDEPEND="${DEPEND}
	!kde-plasmoids/toggle-compositing"

S="${WORKDIR}/${MY_P}"
