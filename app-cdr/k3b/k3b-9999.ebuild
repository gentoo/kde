# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

WEBKIT_REQUIRED="always"
KMNAME="extragear/multimedia"
inherit kde4-base

DESCRIPTION="K3b, KDE CD Writing Software"
HOMEPAGE="http://www.k3b.org/"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS=""
IUSE="debug dvd emovix encode ffmpeg flac mad lame musicbrainz musepack sndfile sox taglib vorbis +wav"

DEPEND="
	>=kde-base/libkcddb-${KDE_MINIMAL}
	media-libs/libsamplerate
	dvd? ( media-libs/libdvdread )
	ffmpeg? ( >=media-video/ffmpeg-0.4.9_p20080206 )
	flac? ( >=media-libs/flac-1.2.1-r2[cxx] )
	encode? (
		lame? ( media-sound/lame )
	)
	mad? ( media-libs/libmad )
	musepack? ( media-libs/libmpcdec )
	musicbrainz? ( media-libs/musicbrainz:1 )
	sndfile? ( media-libs/libsndfile )
	taglib? ( >=media-libs/taglib-1.5 )
	vorbis? ( media-libs/libvorbis )
"
RDEPEND="${DEPEND}
	>=app-cdr/cdrdao-1.1.7-r3
	>=media-sound/cdparanoia-3.9.8
	virtual/cdrtools
	dvd? (
		>=app-cdr/dvd+rw-tools-7.0
		encode? ( media-video/transcode[dvd] )
	)
	emovix? ( media-video/emovix )
	encode? (
		sox? ( media-sound/sox )
	)
	vcd? ( media-video/vcdimager )
"

DOCS="FAQ KNOWNBUGS PERMISSIONS"

src_configure() {
	# Common settings
	mycmakeargs="${mycmakeargs}
		-DK3B_BUILD_K3BSETUP=OFF
		$(cmake-utils_use debug K3B_DEBUG)
		$(cmake-utils_use musicbrainz K3B_ENABLE_MUSICBRAINZ)
		$(cmake-utils_use dvd K3B_ENABLE_DVD_RIPPING)
		$(cmake-utils_use taglib K3B_ENABLE_TAGLIB)
		-DK3B_BUILD_API_DOCS=OFF
		$(cmake-utils_use ffmpeg K3B_BUILD_FFMPEG_DECODER_PLUGIN)
		$(cmake-utils_use vorbis K3B_BUILD_OGGVORBIS_DECODER_PLUGIN)
		$(cmake-utils_use mad K3B_BUILD_MAD_DECODER_PLUGIN)
		$(cmake-utils_use musepack K3B_BUILD_MUSE_DECODER_PLUGIN)
		$(cmake-utils_use flac K3B_BUILD_FLAC_DECODER_PLUGIN)
		$(cmake-utils_use sndfile K3B_BUILD_SNDFILE_DECODER_PLUGIN)
		$(cmake-utils_use wav K3B_BUILD_WAVE_DECODER_PLUGIN)
		$(cmake-utils_use encode K3B_BUILD_EXTERNAL_ENCODER_PLUGIN)"

	# Encoder settings
	if use encode; then
		mycmakeargs="${mycmakeargs}
			$(cmake-utils_use vorbis K3B_BUILD_OGGVORBIS_ENCODER_PLUGIN)
			$(cmake-utils_use lame K3B_BUILD_LAME_ENCODER_PLUGIN)
			$(cmake-utils_use sox K3B_BUILD_SOX_ENCODER_PLUGIN)"
	fi

	kde4-base_src_configure
}

pkg_postinst() {
	kde4-base_pkg_postinst

	echo
	elog "We don't install k3bsetup anymore because Gentoo doesn't need it."
	elog "If you get warnings on start-up, uncheck the \"Check system"
	elog "configuration\" option in the \"Misc\" settings window."
	echo

	local group=cdrom
	use kernel_linux || group=operator
	elog "Make sure you have proper read/write permissions on the cdrom device(s)."
	elog "Usually, it is sufficient to be in the ${group} group."
	echo
}
