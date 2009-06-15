# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KDE_LINGUAS="cs de es pl pt ru uk"
inherit kde4-base

DESCRIPTION="kradio is a radio tuner application for KDE"
HOMEPAGE="http://kradio.sourceforge.net/"
ESVN_REPO_URI="https://${PN}.svn.sourceforge.net/svnroot/${PN}/trunk"
ESVN_PROJECT="kradio"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="alsa debug encode ffmpeg lirc +mp3 +vorbis v4l2"

DEPEND="
	media-libs/libsndfile
	alsa? ( media-libs/alsa-lib )
	lirc? ( app-misc/lirc )
	mp3? ( media-sound/lame )
	vorbis? (
		media-libs/libvorbis
		media-libs/libogg
	)
	ffmpeg? (
		>=media-libs/libmms-0.4
		>=media-video/ffmpeg-0.5
	)
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs="$(cmake-utils_use_with alsa)
		$(cmake-utils_use_with mp3 LAME)
		$(cmake-utils_use_with vorbis OGG_VORBIS)
		$(cmake-utils_use_with lirc)
		$(cmake-utils_use_with ffmpeg)
		$(cmake-utils_use_with v4l2)"

	kde4-base_src_configure
}
