# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5

DESCRIPTION="Power management for KDE Plasma Shell"
HOMEPAGE="https://projects.kde.org/projects/kde/workspace/powerdevil"
KEYWORDS=" ~amd64"
IUSE="+upower"

DEPEND="
	$(add_frameworks_dep kauth)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep kglobalaccel)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kidletime)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep knotifyconfig)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep solid)
	$(add_plasma_dep plasma-workspace)
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXext
	x11-libs/libXrandr
	upower? ( virtual/udev )
"

RDEPEND="
	${DEPEND}
	upower? ( || ( >=sys-power/upower-0.9.23 sys-power/upower-pm-utils ) )
	!kde-base/powerdevil
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package upower UDev)
	)

	kde5_src_configure
}
