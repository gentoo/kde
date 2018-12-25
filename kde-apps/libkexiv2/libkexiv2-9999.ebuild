# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

KDE_BLOCK_SLOT4="false"
inherit kde5

DESCRIPTION="Wrapper around exiv2 library"
LICENSE="GPL-2+"
KEYWORDS=""
IUSE="+xmp"

DEPEND="
	$(add_qt_dep qtgui)
	>=media-gfx/exiv2-0.25:=[xmp=]
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-18.12.0-exiv2-0.27.patch" )
