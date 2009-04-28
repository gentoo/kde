# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="Media player for KDE using xine and gstreamer backends."
HOMEPAGE="http://kaffeine.sourceforge.net/"
SRC_URI="mirror://sourceforge/kaffeine/${P/_/-}.tar.gz"
LICENSE="GPL-2"
KEYWORDS=""
SLOT="0"
IUSE="debug"

RDEPEND="
	>=media-libs/xine-lib-1.1.12
	x11-libs/libXtst
"
DEPEND="${RDEPEND}
	x11-proto/inputproto
	media-tv/linuxtv-dvb-headers
"
S=${WORKDIR}/${P/_/-}

DOCS="AUTHORS TODO"
