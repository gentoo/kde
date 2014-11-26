# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

QT4_MINIMAL="4.7.0"
QT5_MINIMAL="5.0.0"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="http://gstreamer.freedesktop.org/src/${PN}/${P}.tar.xz"
	KEYWORDS="~amd64 ~arm ~x86"
else
	GIT_ECLASS="git-r3"
	EGIT_REPO_URI=( "git://anongit.freedesktop.org/gstreamer/${PN}" )
	KEYWORDS=""
fi

inherit cmake-utils ${GIT_ECLASS} multibuild

DESCRIPTION="QtGStreamer provides C++ bindings for GStreamer with a Qt-style API"
HOMEPAGE="http://gstreamer.freedesktop.org/modules/qt-gstreamer.html"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="qt4 qt5 test"

RDEPEND="
	dev-libs/glib:2
	>=dev-libs/boost-1.40:=
	qt4? (
		>=dev-qt/qtcore-${QT4_MINIMAL}:4
		>=dev-qt/qtdeclarative-${QT4_MINIMAL}:4
		>=dev-qt/qtgui-${QT4_MINIMAL}:4
		>=dev-qt/qtopengl-${QT4_MINIMAL}:4
	)
	qt5? (
		>=dev-qt/qtcore-${QT5_MINIMAL}:5
		>=dev-qt/qtdeclarative-${QT5_MINIMAL}:5
		>=dev-qt/qtgui-${QT5_MINIMAL}:5
		>=dev-qt/qtopengl-${QT5_MINIMAL}:5
		>=dev-qt/qtquick1-${QT5_MINIMAL}:5
		>=dev-qt/qtwidgets-${QT5_MINIMAL}:5
	)
	media-libs/gstreamer:1.0
	media-libs/gst-plugins-base:1.0
"
DEPEND="
	${RDEPEND}
	test? (
		qt4? (
			>=dev-qt/qttest-${QT4_MINIMAL}:4
		)
	)
"

# bug 497880
RESTRICT="test"

pkg_setup() {
	MULTIBUILD_VARIANTS=()
	if use qt4; then
		MULTIBUILD_VARIANTS+=(qt4)
	fi
	if use qt5; then
		MULTIBUILD_VARIANTS+=(qt5)
	fi
}

src_configure() {
	myconfigure() {
		local mycmakeargs=(
			-DQTGSTREAMER_EXAMPLES=OFF
			$(cmake-utils_use test QTGSTREAMER_TESTS)
		)
		if [[ ${MULTIBUILD_VARIANT} = qt4 ]]; then
			mycmakeargs+=(-DQT_VERSION=4)
		fi
		if [[ ${MULTIBUILD_VARIANT} = qt5 ]]; then
			mycmakeargs+=(-DQT_VERSION=5)
		fi
		cmake-utils_src_configure
	}

	multibuild_foreach_variant myconfigure
}

src_compile() {
	multibuild_foreach_variant cmake-utils_src_compile
}

src_install() {
	multibuild_foreach_variant cmake-utils_src_install
}
