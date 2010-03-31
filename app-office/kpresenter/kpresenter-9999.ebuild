# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="koffice"
KMMODULE="${PN}"
inherit kde4-meta

DESCRIPTION="KOffice presentation program."

KEYWORDS=""
IUSE=""

DEPEND=">=dev-libs/boost-1.35.0"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	filters/libmsooxml/
	libs/
"
KMEXTRA="
	filters/${KMMODULE}/
	filters/libmso/
"

KMLOADLIBS="koffice-libs"
