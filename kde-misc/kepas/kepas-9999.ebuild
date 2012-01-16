# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KMNAME="playground/network"
inherit kde4-base

DESCRIPTION="KDE Easy Publish and Share."
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=73968"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="0"
IUSE="debug oscar zeroconf"

RDEPEND="
	!kde-plasmoids/kepas
	$(add_kdebase_dep plasma-workspace)
	oscar? ( $(add_kdebase_dep kopete oscar) )
	zeroconf? ( $(add_kdebase_dep kdnssd) )
"
