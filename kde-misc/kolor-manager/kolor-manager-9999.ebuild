# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECM_HANDBOOK="optional"
ECM_PO_DIRS="doc/user/po"
inherit ecm kde.org

DESCRIPTION="KControl module for Oyranos CMS cross desktop settings"
HOMEPAGE="https://www.oyranos.org/kolormanager/"

LICENSE="BSD-2"
SLOT="5"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-qt/qtwidgets:5
	kde-frameworks/kconfigwidgets:5
	kde-frameworks/kcoreaddons:5
	kde-frameworks/ki18n:5
	media-gfx/synnefo
	media-libs/libXcm
	>=media-libs/oyranos-0.9.6
	x11-libs/libXrandr
"
RDEPEND="${DEPEND}"
