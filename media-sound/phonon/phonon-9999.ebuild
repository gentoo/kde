# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit cmake-utils subversion

DESCRIPTION="KDE multimedia API"
HOMEPAGE="http://phonon.kde.org"
ESVN_REPO_URI="svn://anonsvn.kde.org/home/kde/trunk/kdesupport/phonon"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="debug gstreamer +xcb +xine"

RDEPEND="
	!kde-base/phonon-xine
	!x11-libs/qt-phonon:4
	>=x11-libs/qt-test-4.4.0:4
	>=x11-libs/qt-dbus-4.4.0:4
	>=x11-libs/qt-gui-4.4.0:4
	gstreamer? (
		media-libs/gstreamer
		media-libs/gst-plugins-base
		>=x11-libs/qt-opengl-4.4.0:4
	)
	xine? (
		>=media-libs/xine-lib-1.1.15-r1[xcb?]
		xcb? ( x11-libs/libxcb )
	)
"
DEPEND="${RDEPEND}
	>=kde-base/automoc-0.9.87
"

pkg_setup() {
	if use !xine && use !gstreamer; then
		die "you must at least select one backend for phonon"
	fi
}

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with gstreamer GStreamer)
		$(cmake-utils_use_with gstreamer GStreamerPlugins)
		$(cmake-utils_use_with xine Xine)"

	if use xine; then
		mycmakeargs="${mycmakeargs}
			$(cmake-utils_use_with xcb XCB)"
	else
		sed -i -e '/xine/d' CMakeLists.txt || die "sed failed"
	fi

	cmake-utils_src_configure
}
