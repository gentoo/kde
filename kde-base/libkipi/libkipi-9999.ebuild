# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdegraphics"
KMMODULE="libs/${PN}"

inherit kde4-meta

DESCRIPTION="A library for image plugins accross KDE applications."
HOMEPAGE="http://www.kipi-plugins.org"

LICENSE="GPL-2"
KEYWORDS=""
IUSE="debug"

DEPEND="
	!kdeprefix? ( !media-libs/libkipi )
"
RDEPEND="${DEPEND}"
