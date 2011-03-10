# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

if [[ ${PV} == *9999 ]]; then
# Not sure how to handle this...
KDE_HANDBOOK="required"
KDE_SCM="git"
inherit kde4-base
else
KDE_HANDBOOK="optional"
KMNAME="kdegraphics"
inherit kde4-meta
fi

DESCRIPTION="Paint Program for KDE"
KEYWORDS=""
LICENSE="BSD LGPL-2"
IUSE="debug"
