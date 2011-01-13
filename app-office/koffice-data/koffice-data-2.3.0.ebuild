# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

KMNAME="koffice"
KMNOMODULE="true"
inherit kde4-meta

DESCRIPTION="Shared KOffice data files"

KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/lcms:0"
RDEPEND="${DEPEND}"

KMEXTRA="pics/
	servicetypes/
	templates/"
KMEXTRACTONLY="
	KoConfig.h.cmake
	doc/CMakeLists.txt
	doc/koffice.desktop"
