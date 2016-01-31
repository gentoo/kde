# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_HANDBOOK="forceoptional"
inherit kde5

DESCRIPTION="A sound editor that can edit many types of audio files"
HOMEPAGE="http://kwave.sourceforge.net/"
if [[ ${KDE_BUILD_TYPE} != live ]]; then
	SRC_URI="mirror://sourceforge/${PN}/${P}-2.tar.bz2"
fi

LICENSE="BSD GPL-2 LGPL-2
	handbook? ( FDL-1.2 )"
KEYWORDS=""
IUSE="alsa flac mp3 qtmedia opus oss pulseaudio vorbis"

COMMON_DEPEND="
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kguiaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kinit)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_qt_dep qtconcurrent)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtwidgets)
	media-libs/audiofile:=
	>=sci-libs/fftw-3
	media-libs/libsamplerate
	alsa? ( media-libs/alsa-lib )
	flac? ( media-libs/flac )
	mp3? (
		media-libs/id3lib
		media-libs/libmad
		|| ( media-sound/lame media-sound/twolame media-sound/toolame )
	)
	qtmedia? ( $(add_qt_dep qtmultimedia) )
	opus? (
		media-libs/libogg
		media-libs/opus
	)
	pulseaudio? ( media-sound/pulseaudio )
	vorbis? (
		media-libs/libogg
		media-libs/libvorbis
	)
"
DEPEND="${COMMON_DEPEND}
	$(add_kdeapps_dep poxml)
	|| ( media-gfx/imagemagick[png,svg] media-gfx/graphicsmagick[imagemagick,png,svg] )
"
RDEPEND="${COMMON_DEPEND}
	!media-sound/kwave:4
"

DOCS=( AUTHORS CHANGES README TODO )

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with alsa)
		$(cmake-utils_use_with handbook DOC)
		$(cmake-utils_use_with flac)
		$(cmake-utils_use_with mp3)
		$(cmake-utils_use_with vorbis OGG_VORBIS)
		$(cmake-utils_use_with opus OGG_OPUS)
		$(cmake-utils_use_with oss)
		$(cmake-utils_use_with pulseaudio)
		$(cmake-utils_use_with qtmedia QT_AUDIO)
		$(cmake-utils_use debug)
	)

	kde5_src_configure
}
