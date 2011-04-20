# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_SCM="git"
if [[ ${PV} == *9999 ]]; then
inherit kde4-base
else
KMNAME="kdegraphics"
KMMODULE="strigi-analyzer"
inherit kde4-meta
fi

DESCRIPTION="kdegraphics: strigi plugins"
KEYWORDS=""
IUSE="debug"

if [[ ${PV} != *9999 ]]; then
KMEXTRACTONLY="
	libs/mobipocket/
"
fi

DEPEND="
	app-misc/strigi
"
RDEPEND="${DEPEND}"
