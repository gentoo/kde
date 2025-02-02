# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="true"
inherit ecm kde.org

DESCRIPTION="Scanning application by KDE"
HOMEPAGE="https://userbase.kde.org/Kooka https://techbase.kde.org/Projects/Kooka"

LICENSE="GPL-2+"
SLOT="5"
KEYWORDS=""

BDEPEND="
	virtual/pkgconfig
"
DEPEND="
	app-text/libpaper
	dev-qt/qtgui:5
	dev-qt/qtprintsupport:5
	dev-qt/qtwidgets:5
	kde-frameworks/kcompletion:5
	kde-frameworks/kconfig:5
	kde-frameworks/kconfigwidgets:5
	kde-frameworks/kcoreaddons:5
	kde-frameworks/ki18n:5
	kde-frameworks/kio:5
	kde-frameworks/kiconthemes:5
	kde-frameworks/kservice:5
	kde-frameworks/ktextwidgets:5
	kde-frameworks/kwidgetsaddons:5
	kde-frameworks/kxmlgui:5
	media-gfx/sane-backends
	media-libs/tiff:=
"
RDEPEND="${DEPEND}"
