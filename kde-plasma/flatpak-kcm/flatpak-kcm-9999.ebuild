# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=9999
QTMIN=6.9.1
inherit ecm plasma.kde.org xdg

DESCRIPTION="Flatpak Permissions Management KCM"
HOMEPAGE="https://invent.kde.org/plasma/flatpak-kcm"

LICENSE="GPL-2 LGPL-2.1+"
SLOT="6"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-libs/glib:2
	>=dev-qt/qtbase-${QTMIN}:6
	>=dev-qt/qtdeclarative-${QTMIN}:6[widgets]
	>=dev-qt/qtsvg-${QTMIN}:6
	>=kde-frameworks/kcmutils-${KFMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kdeclarative-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kitemmodels-${KFMIN}:6
	>=sys-apps/flatpak-0.11.8
"
RDEPEND="${DEPEND}
	>=kde-frameworks/kirigami-${KFMIN}:6
"
BDEPEND=">=kde-frameworks/kcmutils-${KFMIN}:6"
