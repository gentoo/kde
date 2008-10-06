# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
KMNAME="koffice"
KMMODULE="${PN}"
NEED_KDE="any"
inherit kde4-meta

DESCRIPTION="KOffice chart application."

KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=app-office/koffice-libs-${PV}:${SLOT}
	dev-cpp/eigen:2
	media-libs/freetype:2
	app-text/libwpd
	app-text/wv2
	media-libs/fontconfig
	media-gfx/imagemagick"

KMEXTRACTONLY="interfaces"
