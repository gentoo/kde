# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KMNAME="kdepim"
EGIT_BRANCH="KDE/4.14"
KMMODULE="icons"
inherit kde4-meta

DESCRIPTION="KDE PIM icons"
IUSE=""
KEYWORDS=""

DEPEND="$(add_kdebase_dep kdepimlibs '-minimal(-)')"
RDEPEND=""
