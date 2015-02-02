# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5

DESCRIPTION="KControl module for xf86-input-synaptics"
HOMEPAGE="https://projects.kde.org/projects/playground/utils/kcm-touchpad"
KEYWORDS=""
IUSE=""

RDEPEND="
	$(add_frameworks_dep kinit)
	$(add_frameworks_dep kcmutils)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kglobalaccel)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep knotifyconfig)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep plasma)
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXi
"
DEPEND="${RDEPEND}
	x11-base/xorg-server
	x11-drivers/xf86-input-synaptics
	>=x11-proto/inputproto-2.0
	x11-proto/xproto
	!kde-misc/kcm_touchpad
	!kde-misc/kcm-touchpad
"
