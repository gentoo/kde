# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5

DESCRIPTION="KDE window manager theme"
HOMEPAGE="https://projects.kde.org/projects/kde/workspace/oxygen"
KEYWORDS=""
IUSE="+kwin"

DEPEND="
	$(add_frameworks_dep frameworkintegration)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kguiaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	x11-libs/libxcb
	kwin? ( $(add_kdeplasma_dep kwin) )
"
RDEPEND="${DEPEND}
	!kde-base/kdebase-cursors
	!kde-base/oxygen
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package kwin KDecorations)
	)

	kde5_src_configure
}
