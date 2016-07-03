# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit kde5

DESCRIPTION="KControl module for Oyranos CMS cross desktop settings"
HOMEPAGE="http://www.oyranos.org/kolormanager"

LICENSE="BSD-2"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep ki18n)
	$(add_qt_dep qtwidgets)
	media-gfx/synnefo
	media-libs/libXcm
	>=media-libs/oyranos-0.9.6
	x11-libs/libXrandr
"
RDEPEND="${DEPEND}"
