# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_HANDBOOK="optional"
KDE_SCM="git"
if [[ ${PV} == *9999 ]]; then
	inherit kde4-base
else
	KMNAME="kdeedu"
	inherit kde4-meta
fi

DESCRIPTION="KDE Japanese dictionary and reference"
KEYWORDS=""
IUSE="debug"
