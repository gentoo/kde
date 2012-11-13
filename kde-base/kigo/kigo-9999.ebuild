# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="KDE Go game"
KEYWORDS=""
IUSE="debug"

RDEPEND="
	games-board/gnugo
"
