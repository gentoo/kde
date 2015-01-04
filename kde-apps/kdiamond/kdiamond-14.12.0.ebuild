# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="KDE: KDiamond is a three-in-a-row game"
HOMEPAGE="
	http://www.kde.org/applications/games/kdiamond/
	http://games.kde.org/game.php?game=kdiamond
"
KEYWORDS=" ~amd64 ~x86"
IUSE="debug"

DEPEND="$(add_kdeapps_dep libkdegames)"
RDEPEND="${DEPEND}"
