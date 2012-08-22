# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_MIMINAL="4.9"
inherit kde4-base

DESCRIPTION="Nonogram logic game for KDE"
HOMEPAGE="ihttps://projects.kde.org/projects/extragear/games/picmi"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS=""
IUSE="debug"

DEPEND="$(add_kdebase_dep libkdegames)"
RDEPEND="${DEPEND}"
