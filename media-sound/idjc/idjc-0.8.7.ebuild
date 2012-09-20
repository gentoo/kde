# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit autotools eutils

PYTHON_DEPEND="2"

DESCRIPTION="A DJ console for ShoutCast/IceCast streaming"
HOMEPAGE="http://idjc.sourceforge.net/"
SRC_URI="mirror://sourceforge/idjc/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
IUSE="aac ffmpeg flac mp3 speex"

DEPEND="
	virtual/pkgconfig
"
RDEPEND="
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
	mp3? (
			dev-python/eyeD3
			media-sound/lame
			>=media-libs/libmad-0.15.1b
	)
	speex? ( >=media-libs/speex-1.2_rc1 )
"

src_prepare() {
	epatch "${FILESDIR}/${P}-fix-compressed-docs.1.patch"
	epatch "${FILESDIR}/${P}-fix-compressed-docs.2.patch"
	epatch "${FILESDIR}/${P}-qa-desktop-file.patch"
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable aac mp4)
}

src_install() {
	dodoc AUTHORS NEWS README ChangeLog || die
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
