# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
KDE_SELINUX_MODULE="games"
inherit kde4-base

DESCRIPTION="KDE: KGoldrunner is a game of action and puzzle solving"
HOMEPAGE="
	http://www.kde.org/applications/games/kgoldrunner/
	http://games.kde.org/game.php?game=kgoldrunner
"
KEYWORDS=""
IUSE="debug"

DEPEND="
	$(add_kdeapps_dep libkdegames '' '14.12.3')
	media-libs/libsndfile
	media-libs/openal
"
RDEPEND="${DEPEND}"
