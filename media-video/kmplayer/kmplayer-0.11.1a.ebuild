# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KDE_LINGUAS="cs da de el en_GB es et fr ga gl it ja km ku lt lv mai nb nds nl
nn pl pt pt_BR ro ru sk sv tr uk"

KMNAME="extragear/multimedia"
inherit kde4-base

MY_P="${P/_/-}"
DESCRIPTION="KMPlayer is a Video player plugin for Konqueror and basic MPlayer/Xine/ffmpeg/ffserver/VDR frontend."
HOMEPAGE="http://kmplayer.kde.org/"
SRC_URI="http://${PN}.kde.org/pkgs/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="1"
IUSE="cairo debug doc expat npp"

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

S="${WORKDIR}/${MY_P}"

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
	# do not install icons
	sed -i \
		-e "s:add_subdirectory(icons):#add_subdirectory(icons):g" \
		CMakeLists.txt || die "removing icons failed"

	# fix the install dir for docs
	sed -i \
		-e "s|\${HTML_INSTALL_DIR}/en|\${HTML_INSTALL_DIR}/en SUBDIR ${PN}|" \
		doc/CMakeLists.txt || die "fixing docs target dir failed"

	# make docs optional
	sed -i \
		-e "s:add_subdirectory(doc):macro_optional_add_subdirectory(doc):g" \
		CMakeLists.txt || die "failed to make docs optional"

	kde4-base_src_prepare
}

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_build doc)
		$(cmake-utils_use cairo KMPLAYER_BUILT_WITH_CAIRO)
		$(cmake-utils_use expat KMPLAYER_BUILT_WITH_EXPAT)
		$(cmake-utils_use npp KMPLAYER_BUILT_WITH_NPP)"

	kde4-base_src_configure
}
