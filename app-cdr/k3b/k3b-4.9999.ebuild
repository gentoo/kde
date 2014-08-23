# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MULTIMEDIA_REQUIRED="always"
WEBKIT_REQUIRED="always"
KDE_HANDBOOK="optional"

# Translations are only in the tarballs, not in the git repo
if [[ ${PV} != *9999* ]]; then
	KDE_LINGUAS="ast be bg ca ca@valencia cs csb da de el en_GB eo es et eu fi fr ga
	gl he hi hne hr hu is it ja km ko ku lt mai nb nds nl nn oc pa pl pt pt_BR ro ru
	se sk sl sv th tr uk zh_CN zh_TW"

	SRC_URI="mirror://sourceforge/${PN}/${P/_}.tar.bz2"
	DOCS=( FAQ PERMISSIONS README )
	S=${WORKDIR}/${P/_*}
else
	DOCS=( FAQ.txt PERMISSIONS.txt README.txt )
fi

inherit kde4-base

DESCRIPTION="The CD/DVD Kreator for KDE"
HOMEPAGE="http://www.k3b.org/"

LICENSE="GPL-2 FDL-1.2"
KEYWORDS=""
SLOT="4"
IUSE="debug dvd emovix encode ffmpeg flac mad mp3 musepack sndfile sox taglib vcd vorbis"

DEPEND="
	$(add_kdebase_dep libkcddb)
	media-libs/libsamplerate
	dvd? ( media-libs/libdvdread )
	ffmpeg? ( virtual/ffmpeg )
	flac? ( >=media-libs/flac-1.2[cxx] )
	mp3? ( media-sound/lame )
	mad? ( media-libs/libmad )
	musepack? ( >=media-sound/musepack-tools-444 )
	sndfile? ( media-libs/libsndfile )
	taglib? ( >=media-libs/taglib-1.5 )
	vorbis? ( media-libs/libvorbis )
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kdelibs 'udev,udisks(+)')
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
"

DOCS+=( ChangeLog )

REQUIRED_USE="
	mp3? ( encode )
	sox? ( encode )
"

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
