# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGIT_BRANCH="kf5"
KDE_HANDBOOK="forceoptional"
KDE_TEST="true"

inherit kde5

DESCRIPTION="The CD/DVD Kreator for KDE"
HOMEPAGE="http://www.k3b.org/"

LICENSE="GPL-2 FDL-1.2"
SLOT="5"
KEYWORDS=""
IUSE="dvd emovix encode ffmpeg flac libav mad mp3 musepack sndfile sox taglib vcd vorbis"

# Translations are only in the tarballs, not in the git repo
if [[ ${KDE_BUILD_TYPE} != live ]] ; then
	SRC_URI="mirror://sourceforge/${PN}/${P/_}.tar.bz2"
	DOCS=( FAQ PERMISSIONS README )
	S=${WORKDIR}/${P/_*}
else
	DOCS=( FAQ.txt PERMISSIONS.txt README.txt )
fi

DEPEND="
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep kcmutils)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep kfilemetadata)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep knotifyconfig)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep solid)
	$(add_kdeapps_dep libkcddb)
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwebkit:5
	dev-qt/qtwidgets:5
	media-libs/libsamplerate
	dvd? ( media-libs/libdvdread )
	ffmpeg? (
		libav? ( media-video/libav:= )
		!libav? ( media-video/ffmpeg:0= )
	)
	flac? ( >=media-libs/flac-1.2[cxx] )
	mp3? ( media-sound/lame )
	mad? ( media-libs/libmad )
	musepack? ( >=media-sound/musepack-tools-444 )
	sndfile? ( media-libs/libsndfile )
	taglib? ( >=media-libs/taglib-1.5 )
	vorbis? ( media-libs/libvorbis )
"
RDEPEND="${DEPEND}
	app-cdr/cdrdao
	media-sound/cdparanoia
	virtual/cdrtools
	dvd? (
		>=app-cdr/dvd+rw-tools-7
		encode? ( media-video/transcode[dvd] )
	)
	emovix? ( media-video/emovix )
	sox? ( media-sound/sox )
	vcd? ( media-video/vcdimager )
	!app-cdr/k3b:4
"

DOCS+=( ChangeLog )

REQUIRED_USE="
	mp3? ( encode )
	sox? ( encode )
"

PATCHES=( "${FILESDIR}/${PN}-tests-optional.patch" )

src_configure() {
	local mycmakeargs=(
		-DK3B_BUILD_API_DOCS=OFF
		-DK3B_BUILD_K3BSETUP=OFF
		-DK3B_BUILD_WAVE_DECODER_PLUGIN=ON
		-DK3B_ENABLE_HAL_SUPPORT=OFF
		-DK3B_ENABLE_MUSICBRAINZ=OFF
		$(cmake-utils_use debug K3B_DEBUG)
		$(cmake-utils_use dvd K3B_ENABLE_DVD_RIPPING)
		$(cmake-utils_use encode K3B_BUILD_EXTERNAL_ENCODER_PLUGIN)
		$(cmake-utils_use ffmpeg K3B_BUILD_FFMPEG_DECODER_PLUGIN)
		$(cmake-utils_use flac K3B_BUILD_FLAC_DECODER_PLUGIN)
		$(cmake-utils_use mp3 K3B_BUILD_LAME_ENCODER_PLUGIN)
		$(cmake-utils_use mad K3B_BUILD_MAD_DECODER_PLUGIN)
		$(cmake-utils_use musepack K3B_BUILD_MUSE_DECODER_PLUGIN)
		$(cmake-utils_use sndfile K3B_BUILD_SNDFILE_DECODER_PLUGIN)
		$(cmake-utils_use sox K3B_BUILD_SOX_ENCODER_PLUGIN)
		$(cmake-utils_use taglib K3B_ENABLE_TAGLIB)
		$(cmake-utils_use vorbis K3B_BUILD_OGGVORBIS_DECODER_PLUGIN)
		$(cmake-utils_use vorbis K3B_BUILD_OGGVORBIS_ENCODER_PLUGIN)
	)
	kde5_src_configure
}

pkg_postinst() {
	kde5_pkg_postinst

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
