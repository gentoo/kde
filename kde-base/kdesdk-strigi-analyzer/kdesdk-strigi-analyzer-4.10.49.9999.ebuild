# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

if [[ ${PV} == *9999 ]]; then
	eclass="kde4-base"
	KMNAME="kdesdk-strigi-analyzers"
else
	eclass="kde4-meta"
	KMNAME="kdesdk"
	KMMODULE="strigi-analyzer"
fi
inherit ${eclass}

DESCRIPTION="kdesdk: strigi plugins"
KEYWORDS=""
IUSE="debug"

DEPEND="
	app-misc/strigi
"
RDEPEND="${DEPEND}"
