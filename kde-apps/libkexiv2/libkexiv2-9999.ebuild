# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

DESCRIPTION="KDE Image Plugin Interface: an exiv2 library wrapper"
KEYWORDS=""
IUSE="debug +xmp"

DEPEND="
	>=media-gfx/exiv2-0.24:=[xmp=]
	virtual/jpeg:0
"
RDEPEND="${DEPEND}"
