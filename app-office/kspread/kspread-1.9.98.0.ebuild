# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
KMNAME="koffice"
KMMODULE="${PN}"
NEED_KDE=":4.1"
inherit kde4-meta

DESCRIPTION="KOffice spreadsheet application."

KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=app-office/kchart-${PV}:${SLOT}
	dev-cpp/eigen:2
	media-gfx/imagemagick
	media-gfx/pstoedit
	media-libs/freetype:2
	media-libs/fontconfig
	media-libs/libart_lgpl"

KMEXTRACTONLY="interfaces
	kchart"

