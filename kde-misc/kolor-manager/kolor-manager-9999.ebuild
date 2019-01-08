# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

KDE_HANDBOOK="optional"
KDE_PO_DIRS="doc/user/po"
inherit kde5

DESCRIPTION="KControl module for Oyranos CMS cross desktop settings"
HOMEPAGE="https://www.oyranos.org/kolormanager"

LICENSE="BSD-2"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep ki18n)
	$(add_qt_dep qtwidgets)
	media-gfx/synnefo
	media-libs/libXcm
	>=media-libs/oyranos-0.9.6
	x11-libs/libXrandr
"
RDEPEND="${DEPEND}"
