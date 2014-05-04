# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5

DESCRIPTION="Power management for the KDE Plasma Shell."
HOMEPAGE="https://projects.kde.org/projects/extragear/base/powerdevil"
KEYWORDS=""
IUSE="+upower X"

COMMON_DEPEND="
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
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep plasma)
	$(add_frameworks_dep solid)
	X? (
		x11-libs/libX11
		x11-libs/libxcb
		x11-libs/libXrandr
	)
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	kde-base/plasma-workspace
"

RDEPEND="
	${COMMON_DEPEND}
	upower? ( sys-power/upower )
	!kde-base/powerdevil:4
"

DEPEND="${COMMON_DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package upower UDev)
		$(cmake-utils_use_find_package X X11)
	)

	kde5_src_configure
}
