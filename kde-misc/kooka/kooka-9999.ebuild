# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="true"
KFMIN=6.9.0
QTMIN=6.8.1
inherit ecm kde.org xdg

DESCRIPTION="Scanning application by KDE"
HOMEPAGE="https://userbase.kde.org/Kooka https://techbase.kde.org/Projects/Kooka"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS=""

DEPEND="
	app-text/libpaper
	dev-qt/qtbase:6[gui,widgets]
	kde-frameworks/kcolorscheme:6
	kde-frameworks/kcompletion:6
	kde-frameworks/kconfig:6
	kde-frameworks/kconfigwidgets:6
	kde-frameworks/kcoreaddons:6
	kde-frameworks/kcrash:6
	kde-frameworks/ki18n:6
	kde-frameworks/kiconthemes:6
	kde-frameworks/kio:6
	kde-frameworks/kservice:6
	kde-frameworks/ktextwidgets:6
	kde-frameworks/kwidgetsaddons:6
	kde-frameworks/kxmlgui:6
	media-gfx/sane-backends
	media-libs/tiff:=
"
RDEPEND="${DEPEND}
	!${CATEGORY}/${PN}:5
"
BDEPEND="virtual/pkgconfig"
