# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
KDE_SELINUX_MODULE="games"
inherit kde4-base

DESCRIPTION="A KDE game similiar to Mahjongg"
HOMEPAGE="
	http://www.kde.org/applications/games/kshisen/
	http://games.kde.org/game.php?game=kshisen
"
KEYWORDS=" ~amd64 ~x86"
IUSE="debug"

DEPEND="
	$(add_kdeapps_dep libkdegames)
	$(add_kdeapps_dep libkmahjongg)
"
RDEPEND="${DEPEND}"
