# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="koffice"
KMMODULE="${PN}"
inherit kde4-meta

DESCRIPTION="KPlato is a project management application."

KEYWORDS=""
IUSE="debug"

DEPEND=""
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	kchart/
	interfaces/
	libs/
	filters/
	plugins/
"
KMEXTRA="
	kdgantt
"

KMLOADLIBS="koffice-libs"
