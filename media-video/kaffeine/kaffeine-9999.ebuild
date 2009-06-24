# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="extragear/multimedia"
KMMODULE="kaffeine"
inherit kde4-base

DESCRIPTION="Media player for KDE using xine and gstreamer backends."
HOMEPAGE="http://kaffeine.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="1"
IUSE="debug dvb xcb encode vorbis"

COMMON_DEPEND="
	>=media-libs/xine-lib-1.1.12
	media-sound/cdparanoia
	x11-libs/libXtst
	encode? ( media-sound/lame )
	vorbis? ( media-libs/libvorbis )
	xcb? ( >=x11-libs/libxcb-1.0 )
"
RDEPEND="${COMMON_DEPEND}
	!kdeprefix? ( !media-video/kaffeine:0 )
"
DEPEND="${COMMON_DEPEND}
	x11-proto/inputproto
	dvb? ( media-tv/linuxtv-dvb-headers )
"
