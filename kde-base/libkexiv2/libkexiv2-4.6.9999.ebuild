# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

if [[ ${PV} == *9999 ]]; then
KDE_SCM="git"
inherit kde4-base
else
KMNAME="kdegraphics"
KMMODULE="libs/libkexiv2"
inherit kde4-meta
fi

DESCRIPTION="KDE Image Plugin Interface: an exiv2 library wrapper"
HOMEPAGE="http://www.kipi-plugins.org"

LICENSE="GPL-2"
KEYWORDS=""
IUSE="debug"

DEPEND="
	>=media-gfx/exiv2-0.18
	media-libs/lcms:0
	virtual/jpeg
"
RDEPEND="${DEPEND}"
