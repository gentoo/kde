# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/phonon/phonon-4.3.0.ebuild,v 1.3 2009/02/05 18:15:28 scarabeus Exp $

EAPI="2"
inherit cmake-utils

KDE_VERSION="4.2.0"

DESCRIPTION="KDE multimedia API"
HOMEPAGE="http://phonon.kde.org"
SRC_URI="mirror://kde/stable/${KDE_VERSION}/src/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
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
		sed -i -e '/xine/d' \
			"${S}/CMakeLists.txt" || die "sed failed"
	fi
	cmake-utils_src_configure
}
