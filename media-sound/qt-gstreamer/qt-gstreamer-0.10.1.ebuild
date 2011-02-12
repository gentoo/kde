# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit cmake-utils

DESCRIPTION="QtGStreamer provides C++ bindings for GStreamer with a Qt-style API."
HOMEPAGE="http://gstreamer.freedesktop.org/wiki/QtGStreamer"
SRC_URI="http://gstreamer.freedesktop.org/src/qt-gstreamer/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-libs/glib
	>=media-libs/gstreamer-0.10.31
	>=media-libs/gst-plugins-base-0.10.31
	>=x11-libs/qt-core-4.6
	>=dev-util/automoc-0.9
	>=dev-util/boost-build-1.40
	sys-devel/flex
	sys-devel/bison
"
DEPEND="
	>=dev-util/cmake-2.8
	${RDEPEND}
"
