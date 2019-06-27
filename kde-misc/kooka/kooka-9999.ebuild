# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_HANDBOOK="true"
inherit kde5

DESCRIPTION="Scanning application by KDE"
HOMEPAGE="https://userbase.kde.org/Kooka https://techbase.kde.org/Projects/Kooka"
KEYWORDS=""

BDEPEND="
	virtual/pkgconfig
"
DEPEND="
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtprintsupport)
	$(add_qt_dep qtwidgets)
	app-text/libpaper
	media-gfx/sane-backends
	media-libs/tiff:0
"
RDEPEND="${DEPEND}"
