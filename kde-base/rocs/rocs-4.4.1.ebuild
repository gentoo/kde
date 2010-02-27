# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

KMNAME="kdeedu"
inherit kde4-meta

DESCRIPTION="KDE4 interface to work with Graph Theory"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook"

DEPEND="
	>=dev-cpp/eigen-2.0.3:2
"
RDEPEND=""
