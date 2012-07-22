# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit kde4-base

DESCRIPTION="KDE4 plasmoid. KDE Easy Publish and Share."
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=73968"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug oscar zeroconf"

RDEPEND="
	!kde-plasmoids/kepas
	$(add_kdebase_dep plasma-workspace)
	oscar? ( $(add_kdebase_dep kopete oscar) )
	zeroconf? ( $(add_kdebase_dep kdnssd) )
"
