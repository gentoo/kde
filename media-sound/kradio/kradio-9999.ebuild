# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_LINGUAS_DIR=( po convert-presets/po )
PLUGINS=(
	alsa-sound dbus gui-docking-menu gui-error-log gui-quickbar
	gui-standard-display internetradio lirc oss-sound radio recording shortcuts
	soundserver streaming timecontrol timeshifter v4lradio
)
KDE_LINGUAS="cs de es is it pl pt pt_BR ru sk tr uk"
inherit kde4-base

DESCRIPTION="kradio is a radio tuner application for KDE"
HOMEPAGE="http://kradio.sourceforge.net/"
EGIT_REPO_URI="git://${PN}.git.sourceforge.net/gitroot/${PN}/${PN}"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="alsa debug encode ffmpeg libav lirc +mp3 +vorbis v4l"

DEPEND="
	media-libs/libsndfile
	alsa? ( media-libs/alsa-lib )
	ffmpeg? (
		>=media-libs/libmms-0.4
		libav? ( media-video/libav:= )
		!libav? ( media-video/ffmpeg:0= )
	)
	lirc? ( app-misc/lirc )
	mp3? ( media-sound/lame )
	vorbis? (
		media-libs/libvorbis
		media-libs/libogg
	)
"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_prepare() {
	local lang
	for lang in ${KDE_LINGUAS} ; do
		if ! use linguas_${lang} ; then
			for dir in "${KDE_LINGUAS_DIR[@]}" ; do
				rm ${dir}/${lang}.po
			done
			for plugin in "${PLUGINS[@]}" ; do
				rm plugins/${plugin}/po/${lang}.po
			done
		fi
	done

	kde4-base_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DWITH_ALSA=$(usex alsa)
		-DWITH_FFMPEG=$(usex ffmpeg)
		-DWITH_LIRC=$(usex lirc)
		-DWITH_LAME=$(usex mp3)
		-DWITH_OGG_VORBIS=$(usex vorbis)
		-DWITH_V4L2=$(usex v4l)
	)

	kde4-base_src_configure
}
