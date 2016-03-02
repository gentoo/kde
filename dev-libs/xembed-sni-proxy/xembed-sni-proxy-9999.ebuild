# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit kde5

DESCRIPTION="Convert XEmbed system tray icons to SNI icons"
EGIT_REPO_URI="https://github.com/davidedmundson/xembed-sni-proxy.git"
LICENSE="LGPL-2.1+"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kwindowsystem)
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtx11extras)
	x11-libs/libxcb
	x11-libs/xcb-util
	x11-libs/xcb-util-image
"
RDEPEND="${DEPEND}"
