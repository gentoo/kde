# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

NEED_KDE="none"
if use kdeprefix; then
	KDEDIR="/usr/kde/4.1"
else
	KDEDIR="/usr"
fi
SLOT=4
inherit kde4-base

DESCRIPTION="KDE multimedia API"
HOMEPAGE="http://phonon.kde.org"
SRC_URI="mirror://kde/stable/${PN}/${PV}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
IUSE="debug gstreamer"

# we do not want qt-phonon at all
# this two libraries block each other
RDEPEND="!kde-base/phonon:kde-svn
	!kde-base/phonon:kde-4
	!media-sound/phonon:0
	!x11-libs/qt-phonon:4
	x11-libs/qt-core:4
	x11-libs/qt-dbus:4
	x11-libs/qt-gui:4
	x11-libs/qt-test:4
	gstreamer? ( media-libs/gstreamer
		media-libs/gst-plugins-base
		x11-libs/qt-opengl:4 )"
DEPEND="${RDEPEND}
	kde-base/automoc"

RESTRICT="test"

PREFIX="${KDEDIR}"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with gstreamer GStreamer)
		$(cmake-utils_use_with gstreamer GStreamerPlugins)"
	cmake-utils_src_compile
}
