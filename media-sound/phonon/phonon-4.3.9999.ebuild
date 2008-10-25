# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit cmake-utils subversion

DESCRIPTION="KDE multimedia API"
HOMEPAGE="http://phonon.kde.org"
ESVN_REPO_URI="svn://anonsvn.kde.org/home/kde/trunk/kdesupport/phonon"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug gstreamer +xine"

RDEPEND="!kde-base/phonon:kde-svn
		!kde-base/phonon:kde-4
		!x11-libs/qt-phonon:4
		x11-libs/qt-core:4
		x11-libs/qt-dbus:4
		x11-libs/qt-gui:4
		x11-libs/qt-test:4
		gstreamer? ( media-libs/gstreamer
					media-libs/gst-plugins-base
					x11-libs/qt-opengl:4 )
		xine? ( >=media-libs/xine-lib-1.1.15-r1
				x11-libs/libxcb )"
DEPEND="${RDEPEND}
	>=kde-base/automoc-0.9.87"

RESTRICT="test"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with gstreamer GStreamer)
		$(cmake-utils_use_with gstreamer GStreamerPlugins)"
	if use !xine; then
		sed -e '326d' -i "${WORKDIR}/${P}/CMakeLists.txt"
	fi
	cmake-utils_src_compile
}
