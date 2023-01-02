# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KDE_ORG_CATEGORY="system"
KDE_ORG_NAME="${PN}-1"
inherit ecm kde.org

DESCRIPTION="Set of configuration modules to change polkit settings"
HOMEPAGE="https://invent.kde.org/system/polkit-kde-kcmodules-1"

LICENSE="GPL-2+"
SLOT="5"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	kde-frameworks/kauth:5
	kde-frameworks/kcmutils:5
	kde-frameworks/kconfigwidgets:5
	kde-frameworks/kcoreaddons:5
	kde-frameworks/ki18n:5
	kde-frameworks/kwidgetsaddons:5
	>=sys-auth/polkit-qt-0.113.0[qt5(+)]
"
DEPEND="${RDEPEND}"
