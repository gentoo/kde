# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

WEBKIT_REQUIRED="allways"
KMNAME="playground/libs"
KMMODULE="webkitkde"
inherit kde4-base

DESCRIPTION="A WebKit KPart for konqueror"
LICENSE="GPL-2"

KEYWORDS=""
IUSE="debug"
SLOT="live"

DEPEND="x11-libs/qt-webkit:4"
RDEPEND="${RDEPEND}
	kde-base/konqueror"
