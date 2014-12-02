# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
KDE_SELINUX_MODULE="games"
inherit kde4-base

DESCRIPTION="KDE Blackbox Game"
KEYWORDS=""
IUSE="debug"

DEPEND="$(add_kdeapps_dep libkdegames)"
RDEPEND="${DEPEND}"
