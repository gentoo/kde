# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils git-2

DESCRIPTION="QtGStreamer provides C++ bindings for GStreamer with a Qt-style API."
HOMEPAGE="http://gstreamer.freedesktop.org/wiki/QtGStreamer"
EGIT_REPO_URI="git://anongit.freedesktop.org/gstreamer/${PN}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-libs/glib
	>=dev-util/boost-build-1.40
	>=media-libs/gstreamer-0.10.33
	>=media-libs/gst-plugins-base-0.10.33
	>=x11-libs/qt-core-4.7:4
	>=x11-libs/qt-declarative-4.7:4
	>=x11-libs/qt-gui-4.7:4
	>=x11-libs/qt-opengl-4.7:4
"
RDEPEND="${DEPEND}"
