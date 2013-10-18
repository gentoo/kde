# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

DESCRIPTION="KDE digital camera raw image library wrapper"
KEYWORDS=""
IUSE="debug"

DEPEND="
	>=media-libs/libraw-0.16:=
"
RDEPEND="${DEPEND}"
