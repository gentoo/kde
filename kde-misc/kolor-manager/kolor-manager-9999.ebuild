# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

DESCRIPTION="KControl module for Oyranos CMS cross desktop settings"
HOMEPAGE="http://www.oyranos.org/wiki/index.php?title=Kolor-manager"

LICENSE="BSD-2"
KEYWORDS=""
SLOT="4"
IUSE="debug"

DEPEND="
	>=media-libs/oyranos-0.9.5
	media-libs/libXcm
	x11-libs/libXrandr
"
RDEPEND="${DEPEND}"
