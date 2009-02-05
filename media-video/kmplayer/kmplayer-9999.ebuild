# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="extragear/multimedia"
inherit kde4-base

DESCRIPTION="KMPlayer is a Video player plugin for Konqueror and basic MPlayer/Xine/ffmpeg/ffserver/VDR frontend."
HOMEPAGE="http://kmplayer.kde.org/"

LICENSE="GPL-2"
SLOT="live"
KEYWORDS=""
IUSE="cairo debug expat npp"

DEPEND="
	x11-libs/libXv
	expat? ( >=dev-libs/expat-2.0.1 )
	cairo? ( x11-libs/cairo )
	npp? (
		>=dev-libs/nspr-4.6.7
		>=x11-libs/gtk+-2.10.14
	)
"
RDEPEND="${DEPEND}
	media-video/mplayer
"

pkg_setup() {
	if use amd64 && ! has_version media-video/mplayer; then
		echo
		elog 'NOTICE: You have mplayer-bin installed; you will need to configure'
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
		$(cmake-utils_use_with cairo CAIRO)
		$(cmake-utils_use_with expat EXPAT)
		$(cmake-utils_use_with npp NPP)"

	kde4-base_src_configure
}
