# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGIT_BRANCH="frameworks"
inherit kde5

DESCRIPTION="KControl module for Oyranos CMS cross desktop settings"
HOMEPAGE="http://www.oyranos.org/wiki/index.php?title=Kolor-manager"

LICENSE="BSD-2"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep ki18n)
	dev-qt/qtwidgets:5
	media-gfx/synnefo[qt5]
	=media-libs/oyranos-9999
	media-libs/libXcm
	x11-libs/libXrandr
"
RDEPEND="${DEPEND}"
