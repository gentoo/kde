# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde-frameworks

DESCRIPTION="Framework for notifying the user of an event, including feedback and persistant events"
KEYWORDS=""
IUSE="X dbus"

RDEPEND="
	$(add_frameworks_dep kcodecs)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep kwindowsystem)
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	media-libs/phonon[qt5]
	dbus? ( dev-libs/libdbusmenu-qt[qt5] )
	X? (
		dev-qt/qtx11extras:5
		x11-libs/libX11
		x11-libs/libXtst
	)
"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package X X11)
		$(cmake-utils_use_find_package dbus DBusMenuQt5)
	)

	kde-frameworks_src_configure
}
