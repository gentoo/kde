# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

QT_MINIMAL="4.8.0"

REV="ce12a27736cb2cc23424800ac2baea254a067803"
SRC_URI="http://github.com/detrout/${PN}/archive/${REV}.zip -> ${P}.zip"
KEYWORDS="~amd64 ~x86"

inherit cmake-utils

DESCRIPTION="QtGStreamer provides C++ bindings for GStreamer with a Qt-style API."
HOMEPAGE="http://gstreamer.freedesktop.org/wiki/QtGStreamer"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="test"

S="${WORKDIR}/${PN}-${REV}"

RDEPEND="
	dev-libs/glib:2
	>=dev-libs/boost-1.40:=
	>=dev-qt/qtcore-${QT_MINIMAL}:4
	>=dev-qt/qtdeclarative-${QT_MINIMAL}:4
	>=dev-qt/qtgui-${QT_MINIMAL}:4
	>=dev-qt/qtopengl-${QT_MINIMAL}:4
	>=dev-util/boost-build-1.40
	media-libs/gstreamer:1.0
	media-libs/gst-plugins-base:1.0
"
DEPEND="
	${RDEPEND}
	test? ( >=dev-qt/qttest-${QT_MINIMAL}:4 )
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use test QTGSTREAMER_TESTS)
	)

	cmake-utils_src_configure
}
