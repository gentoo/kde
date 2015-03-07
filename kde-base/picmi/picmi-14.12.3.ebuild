# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

DESCRIPTION="Nonogram logic game for KDE"
HOMEPAGE="http://games.kde.org/game.php?game=picmi"
KEYWORDS=" ~amd64 ~x86"
IUSE="debug"

DEPEND="$(add_kdebase_dep libkdegames)"
RDEPEND="${DEPEND}"

RESTRICT=test
# needs X server
