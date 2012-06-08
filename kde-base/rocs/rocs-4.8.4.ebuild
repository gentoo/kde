# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="KDE4 interface to work with Graph Theory"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND=">=dev-libs/boost-1.43"
DEPEND="
	${RDEPEND}
	>=dev-cpp/eigen-2.0.3:2
"

RESTRICT="test"
# bug 376909
