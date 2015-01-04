# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="KDE: Ksirk is a KDE port of the board game risk"
HOMEPAGE="
	http://www.kde.org/applications/games/ksirk/
	http://games.kde.org/game.php?game=ksirk
"
KEYWORDS=""
IUSE="debug"

DEPEND="
	app-crypt/qca:2
	$(add_kdeapps_dep libkdegames)
	sys-libs/zlib
"
RDEPEND="${DEPEND}"
