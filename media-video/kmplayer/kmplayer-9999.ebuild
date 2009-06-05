# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="extragear/multimedia"
inherit kde4-base

DESCRIPTION="KMPlayer is a Video player plugin for Konqueror and basic MPlayer/Xine/ffmpeg/ffserver/VDR frontend."
HOMEPAGE="http://kmplayer.kde.org/"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="cairo debug expat npp"

DEPEND="
	expat? ( >=dev-libs/expat-2.0.1 )
	cairo? (
		x11-libs/cairo
		x11-libs/pango
	)
	npp? (
		dev-libs/dbus-glib
		>=x11-libs/gtk+-2.10.14
	)
"
RDEPEND="${DEPEND}
	!media-video/kmplayer:4.1
	|| (
		media-video/mplayer
		media-video/mplayer-bin
	)
"

pkg_setup() {
	if has_version "media-video/mplayer-bin"; then
		echo
		elog 'NOTICE: You have mplayer-bin installed; you may need to configure'
		elog 'NOTICE: kmplayer to use it from within the application.'
		echo
	fi

	kde4-base_pkg_setup
}

src_prepare() {
	# fixup icon install
	sed -i \
		-e "s:add_subdirectory(icons):#add_subdirectory(icons):g"\
		CMakeLists.txt || die "removing icons failed"

	kde4-base_src_prepare
}

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use cairo KMPLAYER_BUILT_WITH_CAIRO)
		$(cmake-utils_use expat KMPLAYER_BUILT_WITH_EXPAT)
		$(cmake-utils_use npp KMPLAYER_BUILT_WITH_NPP)"

	kde4-base_src_configure
}
