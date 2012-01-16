# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

MY_P=${PN/kdegraphics-/}-${PV}
KDE_SCM="git"
inherit kde4-base
SRC_URI="mirror://kde/unstable/${PV}/src/${MY_P}.tar.bz2"

DESCRIPTION="Library to support mobipocket ebooks"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

S=${WORKDIR}/${MY_P}
