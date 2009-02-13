# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
KMNAME="koffice"
KMMODULE="${PN}"

inherit kde4-meta

DESCRIPTION="KOffice vector drawing application."

KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	media-gfx/pstoedit
	media-libs/libart_lgpl
"
RDEPEND="${DEPEND}"

KMEXTRA="filters/${KMMODULE}"


