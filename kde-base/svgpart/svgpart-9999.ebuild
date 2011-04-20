# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_SCM="git"
if [[ ${PV} == *9999 ]]; then
	inherit kde4-base
else
	KMNAME="kdegraphics"
	inherit kde4-meta
fi

DESCRIPTION="Svgpart is a kpart for viewing SVGs"
KEYWORDS=""
IUSE="debug"
