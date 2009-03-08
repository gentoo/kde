# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

WEBKIT_REQUIRED="always"
KMNAME="playground/libs"
KMMODULE="webkitkde"
inherit kde4-base

DESCRIPTION="A WebKit KPart for konqueror"
LICENSE="GPL-2"
KEYWORDS=""
SLOT="0"
IUSE="debug"

DEPEND="
	x11-libs/qt-webkit:4
"
RDEPEND="${DEPEND}
	>=kde-base/konqueror-${KDE_MINIMAL}[kdeprefix=]
"
