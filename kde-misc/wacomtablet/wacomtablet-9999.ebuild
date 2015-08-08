# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGIT_BRANCH="kf5-port"
KDE_DOC_DIR="doc/user"
KDE_HANDBOOK="true"
VIRTUALX_REQUIRED="test"
inherit kde5

DESCRIPTION="KControl module for Wacom tablets"
HOMEPAGE="http://kde-apps.org/content/show.php?action=content&content=114856"

LICENSE="GPL-2"
KEYWORDS=""
IUSE=""

CDEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kglobalaccel)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep plasma)
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	>=x11-drivers/xf86-input-wacom-0.20.0
	x11-libs/libX11
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libxcb
"
DEPEND="${CDEPEND}
	sys-devel/gettext
	x11-proto/xproto
"
RDEPEND="${CDEPEND}
	!kde-misc/wacomtablet:4
"
