# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

KMNAME="kdegraphics"
KMMODULE="libs/libkexiv2"
inherit kde4-meta

DESCRIPTION="KDE Image Plugin Interface: an exiv2 library wrapper"
HOMEPAGE="http://www.kipi-plugins.org"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	>=media-gfx/exiv2-0.18
	media-libs/lcms:0
	virtual/jpeg
"
RDEPEND="${DEPEND}"
