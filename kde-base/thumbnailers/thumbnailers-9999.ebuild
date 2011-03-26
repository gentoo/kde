# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

if [[ ${PV} == *9999 ]]; then
KDE_SCM="git"
KMNAME="kdegraphics-thumbnailers"
inherit kde4-base
else
KMNAME="kdegraphics"
inherit kde4-meta
fi

DESCRIPTION="KDE 4 thumbnail generators for PDF/PS files"
KEYWORDS=""
IUSE="debug"

if [[ ${PV} != *9999 ]]; then
KMEXTRACTONLY="
	libs/mobipocket
"
fi

DEPEND="
	$(add_kdebase_dep libkdcraw)
	$(add_kdebase_dep libkexiv2)
	media-libs/lcms:0
"
RDEPEND="${DEPEND}"

add_blocker kdegraphics-strigi-analyzer '<4.2.91'
