# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
KMNAME="koffice"
KMMODULE="${PN}"

inherit kde4-meta

DESCRIPTION="KOffice word processor."

KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	app-text/libwpd
	app-text/wv2
	dev-cpp/eigen:2
	media-gfx/imagemagick
	media-libs/fontconfig
	media-libs/freetype:2
"
