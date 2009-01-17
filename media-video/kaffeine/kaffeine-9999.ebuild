# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="extragear/multimedia"
KMMODULE="kaffeinegl"
inherit kde4-base

DESCRIPTION="Media player for KDE using xine and gstreamer backends."
HOMEPAGE="http://kaffeine.sourceforge.net/"
LICENSE="GPL-2"

SLOT="live"
KEYWORDS=""
IUSE="dvb xcb encode vorbis"

RDEPEND=">=media-libs/xine-lib-1.1.12
	xcb? ( >=x11-libs/libxcb-1.0 )
	media-sound/cdparanoia
	encode? ( media-sound/lame )
	vorbis? ( media-libs/libvorbis )
	x11-libs/libXtst"
DEPEND="${RDEPEND}
	dvb? ( media-tv/linuxtv-dvb-headers )
	x11-proto/inputproto"
