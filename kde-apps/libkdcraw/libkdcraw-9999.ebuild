# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_BLOCK_SLOT4="false"
inherit kde5

DESCRIPTION="Digital camera raw image library wrapper"
KEYWORDS=""
IUSE=""

DEPEND="
	>=media-libs/libraw-0.16:=
	$(add_qt_dep qtgui)
"
RDEPEND="${DEPEND}"
