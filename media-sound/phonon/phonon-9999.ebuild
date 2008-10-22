# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"
HOMEPAGE="http://phonon.kde.org"
inherit cmake-utils subversion

DESCRIPTION="KDE multimedia API"
KEYWORDS=""
IUSE="debug gstreamer +xine"
ESVN_REPO_URI="svn://anonsvn.kde.org/home/kde/trunk/kdesupport/phonon"
SLOT="0"

LICENSE="GPL-2"

RDEPEND="!kde-base/phonon:kde-svn
	!x11-libs/qt-phonon:4
	>=x11-libs/qt-test-4.4.0:4
	>=x11-libs/qt-dbus-4.4.0:4
	>=x11-libs/qt-gui-4.4.0:4
	gstreamer? ( media-libs/gstreamer
		media-libs/gst-plugins-base
		>=x11-libs/qt-opengl-4.4.0:4 )
	xine? ( >=media-libs/xine-lib-1.1.15-r1
		x11-libs/libxcb )"
DEPEND="${RDEPEND}
	>=kde-base/automoc-0.9.86"

pkg_setup() {
	if use !xine && use !gstreamer; then
		die "you must at least select one backend for phonon"
	fi
}

src_compile() {

	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with gstreamer GStreamer)
		$(cmake-utils_use_with gstreamer GStreamerPlugins)"

	if use !xine; then
		sed -e '326d' -i ${WORKDIR}/${P}/CMakeLists.txt
	fi
	cmake-utils_src_compile
}
