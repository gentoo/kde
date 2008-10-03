# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
KMNAME="koffice"
NEED_KDE="4.1"
inherit kde4-meta

DESCRIPTION="KOffice vector drawing application."
HOMEPAGE="http://www.koffice.org/"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=app-office/koffice-libs-${PV}:${SLOT}
		media-gfx/imagemagick
		media-libs/freetype:2
		media-libs/fontconfig
		media-libs/libart_lgpl"

KMCOPYLIB="
        libkformula lib/kformula
        libkofficecore lib/kofficecore
        libkofficeui lib/kofficeui
        libkopainter lib/kopainter
        libkopalette lib/kopalette
        libkotext lib/kotext
        libkwmf lib/kwmf
        libkowmf lib/kwmf
        libkstore lib/store"
KMEXTRACTONLY="lib/"
KMEXTRA="
		filters/karbon
		plugins/simpletextshape
		plugins/pictureshape
		plugins/pathshapes
		"

