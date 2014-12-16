# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
VIRTUALX_REQUIRED="test"
inherit kde4-base

DESCRIPTION="Kill the bots or they kill you!"
HOMEPAGE="http://www.kde.org/applications/games/killbots/"
KEYWORDS=" ~amd64 ~x86"
IUSE="debug"

DEPEND="$(add_kdeapps_dep libkdegames)"
RDEPEND="${DEPEND}"
