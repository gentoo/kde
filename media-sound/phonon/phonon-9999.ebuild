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
IUSE="alsa debug gstreamer +xcb +xine"
#pulseaudio

RDEPEND="
	!kde-base/phonon-xine
	!x11-libs/qt-phonon:4
	dev-libs/glib:2
	>=x11-libs/qt-test-4.4.0:4
	>=x11-libs/qt-dbus-4.4.0:4
	>=x11-libs/qt-gui-4.4.0:4
	>=x11-libs/qt-opengl-4.4.0:4
	gstreamer? (
		media-libs/gstreamer
		media-libs/gst-plugins-base
		alsa? ( media-libs/alsa-lib )
	)
	xine? (
		>=media-libs/xine-lib-1.1.15-r1[xcb?]
		xcb? ( x11-libs/libxcb )
	)
"
#	pulseaudio? (
#		>=media-sound/pulseaudio-0.9.21[glib]
#	)
DEPEND="${RDEPEND}
	>=kde-base/automoc-0.9.87
"

pkg_setup() {
	if use !xine && use !gstreamer; then
		die "you must at least select one backend for phonon"
	fi
}

src_configure() {
	# glib *should* only be needed with USE=pulseaudio; unfortunately, that is
	# not the case
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with alsa)
		$(cmake-utils_use_with gstreamer GStreamer)
		$(cmake-utils_use_with gstreamer GStreamerPlugins)
		$(cmake-utils_use_with xine)
		$(cmake-utils_use_with xcb)
		-DWITH_PulseAudio=OFF
		-DWITH_GLib2=ON
	"
	#	$(cmake-utils_use_with pulseaudio PulseAudio)

	cmake-utils_src_configure
}
