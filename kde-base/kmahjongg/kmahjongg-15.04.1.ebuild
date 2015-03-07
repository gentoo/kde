# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
KDE_SELINUX_MODULE="games"
inherit kde4-base

DESCRIPTION="Mahjongg for KDE"
HOMEPAGE="
	http://www.kde.org/applications/games/kmahjongg/
	http://games.kde.org/game.php?game=kmahjongg
"
KEYWORDS=" ~amd64 ~x86"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep libkdegames '' '14.12.3')
	$(add_kdebase_dep libkmahjongg '' '14.12.3')
"
RDEPEND="${DEPEND}"
