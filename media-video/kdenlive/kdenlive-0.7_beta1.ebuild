# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

NEED_KDE=":4.1"
KDE_LINGUAS="de zh"
inherit kde4-base

DESCRIPTION="Kdenlive! (pronounced Kay-den-live) is a Non Linear Video Editing Suite for KDE."
HOMEPAGE="http://www.kdenlive.org/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${PV/_/}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk"

DEPEND="dev-libs/libxml2
	media-libs/ladspa-cmt
	media-libs/ladspa-sdk
	media-libs/libdv
	media-libs/libmad
	media-libs/libogg
	media-libs/libsamplerate
	media-libs/libsdl[X,opengl]
	media-libs/libvorbis
	>=media-libs/mlt-0.3.0[dv,ffmpeg,lame,libsamplerate,ogg,sdl,sox,vorbis,xml]
	>=media-libs/mlt++-0.3.0
	media-libs/sdl-image[gif,jpeg,png,tiff]
	media-sound/sox
	media-video/dvgrab
	media-video/ffmpeg[X,sdl]
	gtk? (
		x11-libs/gtk+:2
		x11-libs/pango
	)"

S="${WORKDIR}"/"${PN}-${PV/_/}"

