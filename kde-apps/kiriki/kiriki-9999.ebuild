# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="Kiriki - a gtali clone for KDE4"
HOMEPAGE="
	http://www.kde.org/applications/games/kiriki/
	http://games.kde.org/game.php?game=kiriki
"
KEYWORDS=""
IUSE="debug"

DEPEND="$(add_kdeapps_dep libkdegames)"
RDEPEND="${DEPEND}"
