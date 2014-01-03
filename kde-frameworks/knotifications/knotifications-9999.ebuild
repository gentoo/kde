# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde-frameworks

DESCRIPTION="User notification framework based on freedesktop protocol"
KEYWORDS=""
IUSE="X dbus"

RDEPEND="
	$(add_frameworks_dep kwindowsystem)
	dev-qt/qtdbus:5
	dev-qt/qtwidgets:5
	X? ( dev-qt/qtx11extras:5 )
	dbus? ( dev-libs/libdbusmenu-qt[qt5] )
"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package X X11)
		$(cmake-utils_use_find_package dbus DBusMenuQt5)
	)

	kde-frameworks_src_configure
}
