# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
DECLARATIVE_REQUIRED="always"
inherit kde4-base

DESCRIPTION="KDE: A Breakout-like game for KDE"
HOMEPAGE="
	http://www.kde.org/applications/games/kbreakout/
	http://games.kde.org/game.php?game=kbreakout
"
KEYWORDS=""
IUSE="debug"

DEPEND="$(add_kdeapps_dep libkdegames)"
RDEPEND="${DEPEND}"
