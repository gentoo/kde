# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="KDE4 plasmoid. KDE Easy Publish and Share."
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=73968"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug oscar zeroconf"

RDEPEND="
	!kde-plasmoids/kepas
	>=kde-base/plasma-workspace-${KDE_MINIMAL}
	oscar? ( >=kde-base/kopete-${KDE_MINIMAL}[oscar] )
	zeroconf? ( >=kde-base/kdnssd-${KDE_MINIMAL} )
"
