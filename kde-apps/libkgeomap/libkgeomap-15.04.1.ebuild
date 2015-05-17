# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_MINIMAL="4.10"
VIRTUALX_REQUIRED="test"
inherit kde4-base

DESCRIPTION="Wrapper library for world map components as marble, openstreetmap and googlemap"
HOMEPAGE="http://www.digikam.org/"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	||  (
		( $(add_kdeapps_dep libkexiv2) $(add_kdeapps_dep marble 'kde,plasma') )
		( $(add_kdebase_dep libkexiv2) $(add_kdebase_dep marble 'kde,plasma') )
	)
"
RDEPEND="${DEPEND}
	!media-libs/libkgeomap"
