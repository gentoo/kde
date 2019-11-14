# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECM_TEST="forceoptional"
KFMIN=5.60.0
QTMIN=5.12.3
VIRTUALX_REQUIRED="test"
inherit ecm kde5

DESCRIPTION="Text-based subtitles editor"
HOMEPAGE="https://github.com/maxrd2/subtitlecomposer"

LICENSE="GPL-2"
SLOT="5"
KEYWORDS=""
IUSE="gstreamer libav mpv unicode xine"

BDEPEND="
	sys-devel/gettext
	virtual/pkgconfig
"
DEPEND="
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtwidgets-${QTMIN}:5
	>=kde-frameworks/kcodecs-${KFMIN}:5
	>=kde-frameworks/kcompletion-${KFMIN}:5
	>=kde-frameworks/kconfig-${KFMIN}:5
	>=kde-frameworks/kconfigwidgets-${KFMIN}:5
	>=kde-frameworks/kcoreaddons-${KFMIN}:5
	>=kde-frameworks/ki18n-${KFMIN}:5
	>=kde-frameworks/kio-${KFMIN}:5
	>=kde-frameworks/kross-${KFMIN}:5
	>=kde-frameworks/ktextwidgets-${KFMIN}:5
	>=kde-frameworks/kwidgetsaddons-${KFMIN}:5
	>=kde-frameworks/kxmlgui-${KFMIN}:5
	>=kde-frameworks/sonnet-${KFMIN}:5
	media-libs/phonon[qt5(+)]
	gstreamer? (
		dev-libs/glib:2
		media-libs/gstreamer:1.0
		media-libs/gst-plugins-base:1.0
	)
	libav? ( media-video/libav:= )
	!libav? ( media-video/ffmpeg:0= )
	mpv? ( media-video/mpv )
	unicode? ( dev-libs/icu:= )
	xine? (
		media-libs/xine-lib
		x11-libs/libX11
		x11-libs/libxcb
	)
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_DISABLE_FIND_PACKAGE_PocketSphinx=ON # bug 616706
		$(cmake-utils_use_find_package gstreamer GStreamer)
		$(cmake-utils_use_find_package mpv MPV)
		$(cmake-utils_use_find_package unicode ICU)
		$(cmake-utils_use_find_package xine Xine)
		$(cmake-utils_use_find_package xine X11)
	)

	ecm_src_configure
}

pkg_postinst() {
	ecm_pkg_postinst

	elog "Some example scripts provided by ${PN} require dev-lang/ruby"
	elog "or dev-lang/python to be installed."
}
