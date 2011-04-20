# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_HANDBOOK="optional"
KDE_SCM="git"
if [[ ${PV} == *9999 ]]; then
	inherit kde4-base
else
	KMNAME="kdegraphics"
	inherit kde4-meta
fi

DESCRIPTION="Paint Program for KDE"
KEYWORDS=""
LICENSE="BSD LGPL-2"
IUSE="debug"
