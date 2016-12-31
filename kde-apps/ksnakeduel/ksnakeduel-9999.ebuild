# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_SELINUX_MODULE="games"
inherit kde4-base

DESCRIPTION="KDE Tron game"
HOMEPAGE="https://www.kde.org/applications/games/ksnakeduel/"
KEYWORDS=""
IUSE="debug"

DEPEND="
	$(add_kdeapps_dep libkdegames)
"
RDEPEND="${DEPEND}"
