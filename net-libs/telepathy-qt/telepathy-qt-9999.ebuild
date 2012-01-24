# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

PYTHON_DEPEND="2:2.5"
EGIT_REPO_URI="git://anongit.freedesktop.org/telepathy/${PN}"

inherit python base cmake-utils git-2

DESCRIPTION="Qt4 bindings for the Telepathy D-Bus protocol"
HOMEPAGE="http://telepathy.freedesktop.org/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="debug farsight glib"

RDEPEND="
	dev-python/dbus-python
	x11-libs/qt-core:4[glib?]
	x11-libs/qt-dbus:4
	farsight? (
		dev-libs/dbus-glib
		dev-libs/libxml2
		media-libs/gstreamer
		net-libs/telepathy-farsight
		>=net-libs/telepathy-glib-0.15.1
	)
	glib? ( dev-libs/glib:2 )
	!net-libs/telepathy-qt4
"
DEPEND="${RDEPEND}
	dev-libs/libxslt
	dev-util/pkgconfig
"

DOCS=( AUTHORS ChangeLog HACKING NEWS README )

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	base_src_prepare

	sed -i -e '/^add_subdirectory(examples)$/d' CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_enable debug DEBUG_OUTPUT)
		$(cmake-utils_use_with glib)
		$(cmake-utils_use_with farsight)
	)
	cmake-utils_src_configure
}
