# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="KSquares is an implementation of the game squares for KDE4"
HOMEPAGE="
	http://www.kde.org/applications/games/ksquares/
	http://games.kde.org/game.php?game=ksquares
"
KEYWORDS=""
IUSE="debug"

DEPEND="$(add_kdebase_dep libkdegames)"
RDEPEND="${DEPEND}"
