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
SLOT="4"
IUSE="debug"

COMMON_DEPEND="
	>=media-libs/xine-lib-1.1.12
	x11-libs/libXtst
"
RDEPEND="${COMMON_DEPEND}
	!kdeprefix? ( !media-video/kaffeine:0 )
	!media-video/kaffeine:1
"
DEPEND="${COMMON_DEPEND}
	media-tv/linuxtv-dvb-headers
	x11-proto/inputproto
"
S=${WORKDIR}/${P/_/-}
