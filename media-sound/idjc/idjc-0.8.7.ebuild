# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

EAPI=4

inherit eutils autotools

PYTHON_DEPEND="2:2.6"

DESCRIPTION="A DJ console for ShoutCast/IceCast streaming"
HOMEPAGE="http://idjc.sourceforge.net/"
SRC_URI="mirror://sourceforge/idjc/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
IUSE="aac ffmpeg flac mp3 mp3-streaming mp3-tagging speex"

DEPEND="
	>=dev-util/pkgconfig-0.9.0
"
	
RDEPEND="${DEPEND}
	dev-python/pygtk
	media-libs/libsamplerate
	media-libs/libshout
	media-libs/libsndfile
	>=media-libs/mutagen-1.18
	>=media-sound/jack-audio-connection-kit-0.116.0
	>=media-sound/vorbis-tools-1.2.0
	aac? ( media-libs/faad2 )
	ffmpeg? ( virtual/ffmpeg )
	flac? ( >=media-libs/flac-1.1.3 )
	mp3? ( >=media-libs/libmad-0.15.1b )
	mp3-streaming? ( media-sound/lame )
	mp3-tagging? ( dev-python/eyeD3 )
	speex? ( >=media-libs/speex-1.2_rc1 )
"

src_configure() {
	econf \
		$(use_enable aac mp4)
}

pkg_postinst() {
	einfo "In order to run idjc you first need to have a JACK sound server running."
	einfo "With all audio apps closed and sound servers on idle type the following:"
	einfo "jackd -d alsa -r 44100 -p 2048"
	einfo "Alternatively to have JACK start automatically when launching idjc:"
	einfo "echo \"/usr/bin/jackd -d alsa -r 44100 -p 2048\" >~/.jackdrc"
	einfo ""
	einfo "If you want to announce tracks playing in idjc to IRC using X-Chat,"
	einfo "copy or link /usr/share/idjc/idjc-announce.py to your ~/.xchat2/ dir."
}
