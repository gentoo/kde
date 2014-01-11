# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

DESCRIPTION="Library to support mobipocket ebooks"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="$(add_kdebase_dep okular)"
RDEPEND=${DEPEND}
