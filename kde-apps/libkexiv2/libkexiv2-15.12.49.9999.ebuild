# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_BLOCK_SLOT4="false"
inherit kde5

DESCRIPTION="KDE Image Plugin Interface: an exiv2 library wrapper"
KEYWORDS=""
IUSE="+xmp"

DEPEND="
	dev-qt/qtgui:5
	>=media-gfx/exiv2-0.25:=[xmp=]
"
RDEPEND="${DEPEND}"
