# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KMNAME="kdepim"
KMMODULE="icons"
inherit kde4-meta

DESCRIPTION="KDE PIM icons"
IUSE=""
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"

DEPEND="$(add_kdebase_dep kdepimlibs)"
RDEPEND=""
