# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
KMNAME="koffice"
KMMODULE="${PN}"

inherit kde4-meta

DESCRIPTION="KOffice image manipulation program."

KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-cpp/eigen:2
	media-gfx/imagemagick
	media-gfx/pstoedit
	media-libs/fontconfig
	media-libs/freetype:2
	media-libs/libart_lgpl
"
