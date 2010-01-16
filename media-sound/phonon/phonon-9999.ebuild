# Copyright 1999-2010 Gentoo Foundation
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
IUSE="alsa aqua debug gstreamer pulseaudio +xcb +xine"

RDEPEND="
	!kde-base/phonon-xine
	!x11-libs/qt-phonon:4
	>=x11-libs/qt-test-4.4.0:4[aqua=]
	>=x11-libs/qt-dbus-4.4.0:4[aqua=]
	>=x11-libs/qt-gui-4.4.0:4[aqua=]
	>=x11-libs/qt-opengl-4.4.0:4[aqua=]
	gstreamer? (
		media-libs/gstreamer
		media-libs/gst-plugins-base
		alsa? ( media-libs/alsa-lib )
	)
	pulseaudio? (
		dev-libs/glib:2
		>=media-sound/pulseaudio-0.9.21[glib]
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
	if use !xine && use !gstreamer && use !aqua; then
		die "you must at least select one backend for phonon"
	fi

	if use xine && use aqua; then
		die "XINE backend needs X11 which is not available for USE=aqua"
	fi
}

src_prepare() {
	# Fix the qt7 backend for MacOS 10.6.
	[[ ${CHOST} == *-darwin10 ]] && epatch "${FILESDIR}"/${PN}-4.4-qt7.patch

	# On MacOS we additionally want the gstreamer plugin.
	if use aqua && use gstreamer; then
		sed -e "/add_subdirectory(qt7)/a add_subdirectory(gstreamer)" \
			-i CMakeLists.txt \
			|| die "failed to enable GStreamer backend"
	fi
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with alsa)
		$(cmake-utils_use_build aqua PHONON_QT7)
		$(cmake-utils_use_with gstreamer GStreamer)
		$(cmake-utils_use_with gstreamer GStreamerPlugins)
		$(cmake-utils_use_with pulseaudio PulseAudio)
		$(cmake-utils_use_with pulseaudio GLib2)
		$(cmake-utils_use_with xine)
		$(cmake-utils_use_with xcb)
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	if use aqua; then
		local MY_PV=4.4.0

		install_name_tool \
			-id "${EPREFIX}/usr/lib/libphonon.${MY_PV::1}.dylib" \
			"${ED}/usr/lib/libphonon.${MY_PV}.dylib" \
			|| die "failed to fix libphonon.${MY_PV}.dylib"

		install_name_tool \
			-id "${EPREFIX}/usr/lib/libphononexperimental.${MY_PV::1}.dylib" \
			-change "libphonon.${MY_PV::1}.dylib" \
				"${EPREFIX}/usr/lib/libphononexperimental.${MY_PV::1}.dylib" \
			"${ED}/usr/lib/libphononexperimental.${MY_PV}.dylib" \
			|| die "failed to fix libphononexperimental.${MY_PV}.dylib"

		# fake the framework for the qt-apps depending on qt-frameworks (qt-webkit)
		dodir /usr/lib/qt4/phonon.framework/Versions/${MY_PV::1}
		dosym ${MY_PV::1} /usr/lib/qt4/phonon.framework/Versions/Current \
			|| die "failed to create symlink"
		dosym ../../../../libphonon.${MY_PV::1}.dylib /usr/lib/qt4/phonon.framework/Versions/${MY_PV::1}/phonon \
			|| die "failed to create symlink"
		dosym Versions/${MY_PV::1}/phonon /usr/lib/qt4/phonon.framework/phonon \
			|| die "failed to create symlink"
	fi
}
