# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KDE_LINGUAS="af cs de es fr it pl ru sk sl"
inherit kde4-base

DESCRIPTION="KDE4 plasmoid. yaWP (Yet Another Weather Plasmoid)"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=94106"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug"

RDEPEND="
	!kde-plasmoids/yawp
	>=kde-base/plasma-workspace-${KDE_MINIMAL}
"
