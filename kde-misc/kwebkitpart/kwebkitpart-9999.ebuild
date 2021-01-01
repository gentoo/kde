# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit ecm kde.org

DESCRIPTION="WebKit KPart for Konqueror"
HOMEPAGE="https://invent.kde.org/libraries/kwebkitpart"

LICENSE="LGPL-2"
SLOT="5"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtprintsupport:5
	>=dev-qt/qtwebkit-5.212.0_pre20180120:5
	dev-qt/qtwidgets:5
	kde-frameworks/kcompletion:5
	kde-frameworks/kconfig:5
	kde-frameworks/kcoreaddons:5
	kde-frameworks/kdewebkit:5
	kde-frameworks/ki18n:5
	kde-frameworks/kiconthemes:5
	kde-frameworks/kio:5
	kde-frameworks/kparts:5
	kde-frameworks/kservice:5
	kde-frameworks/kwidgetsaddons:5
	kde-frameworks/kxmlgui:5
	kde-frameworks/sonnet:5
"
RDEPEND="${DEPEND}"
