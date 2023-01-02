# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ ${PV} != *9999* ]]; then
	SRC_URI="https://gstreamer.freedesktop.org/src/${PN}/${P}.tar.xz"
	KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~x86"
else
	EGIT_REPO_URI="https://anongit.freedesktop.org/git/gstreamer/${PN}.git"
	inherit git-r3
fi
inherit cmake

DESCRIPTION="C++ bindings for GStreamer with a Qt-style API"
HOMEPAGE="https://gstreamer.freedesktop.org/modules/qt-gstreamer.html"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="test"

BDEPEND="
	dev-util/glib-utils
"
RDEPEND="
	dev-libs/boost:=
	dev-libs/glib:2
	dev-qt/qtcore:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtopengl:5
	dev-qt/qtwidgets:5
	media-libs/gstreamer:1.0
	media-libs/gst-plugins-base:1.0
"
DEPEND="${RDEPEND}
	test? ( dev-qt/qttest:5 )
"

# bug 497880
RESTRICT="test"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_DISABLE_FIND_PACKAGE_Qt5Declarative=ON
		-DQTGSTREAMER_EXAMPLES=OFF
		-DQTGSTREAMER_TESTS=$(usex test)
		-DQT_VERSION=5
	)
	cmake_src_configure
}
