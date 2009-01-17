# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdegraphics"
KMMODULE="libs/${PN}"

inherit kde4-meta

DESCRIPTION="KDE Image Plugin Interface: a dcraw library wrapper"
HOMEPAGE="http://www.kipi-plugins.org"

LICENSE="GPL-2"
KEYWORDS=""
IUSE="debug"

DEPEND="
	media-libs/jpeg
	media-libs/lcms
	!kdeprefix? ( !media-libs/libkdcraw )
"
RDEPEND="${DEPEND}"
