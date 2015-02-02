# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
EGIT_BRANCH="Applications/14.12"
inherit kde4-base

DESCRIPTION="Kompare is a program to view the differences between files"
HOMEPAGE="http://www.kde.org/applications/development/kompare
http://www.caffeinated.me.uk/kompare"
KEYWORDS=""
IUSE="debug"

DEPEND="$(add_kdeapps_dep libkomparediff2)"
RDEPEND="${DEPEND}"
