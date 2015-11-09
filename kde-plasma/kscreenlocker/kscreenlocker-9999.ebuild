# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit kde5

DESCRIPTION="KDE Plasma Screen Locker"
KEYWORDS=""
IUSE=""

COMMON_DEPEND="
"
RDEPEND="
	$(add_frameworks_dep kcmutils)
	$(add_frameworks_dep kcrash)
	$(add_frameworks_dep kdeclarative)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep kglobalaccel)
	$(add_frameworks_dep kidletime)
	$(add_frameworks_dep plasma)
	$(add_plasma_dep kwayland)
	dev-libs/wayland
	dev-qt/qtx11extras:5
	x11-libs/libX11
	x11-libs/libXi
	x11-libs/libxcb
	x11-libs/xcb-util-keysyms
"
DEPEND="${RDEPEND}"
