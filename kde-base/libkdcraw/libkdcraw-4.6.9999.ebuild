# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_SCM="git"
if [[ ${PV} == *9999 ]]; then
	inherit kde4-base
else
	KMNAME="kdegraphics"
	KMMODULE="libs/${PN}"
	inherit kde4-meta
fi

DESCRIPTION="KDE digital camera raw image library wrapper"
HOMEPAGE="http://www.kipi-plugins.org"

LICENSE="GPL-2"
KEYWORDS=""
IUSE="debug"

DEPEND="
	media-libs/lcms:0
	virtual/jpeg
"
RDEPEND="${DEPEND}"
