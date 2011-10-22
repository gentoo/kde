# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
PYTHON_DEPEND="2"

inherit python base cmake-utils

DESCRIPTION="Qt4 bindings for the Telepathy D-Bus protocol"
HOMEPAGE="http://telepathy.freedesktop.org/"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug glib farsight"

RDEPEND="
	x11-libs/qt-core:4[glib?]
	x11-libs/qt-dbus:4
	dev-python/dbus-python
	farsight? (
		dev-libs/dbus-glib
		dev-libs/libxml2
		media-libs/gstreamer
		>=net-libs/telepathy-glib-0.15.1
		net-libs/telepathy-farsight
	)
"
DEPEND="${RDEPEND}
	dev-libs/libxslt
	dev-util/pkgconfig"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_enable debug DEBUG_OUTPUT)
		$(cmake-utils_use_with glib)
		$(cmake-utils_use_with farsight)
	)
	cmake-utils_src_configure
}
