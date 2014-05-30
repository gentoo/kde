# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDEBASE="kdevelop"
inherit kde4-base

if [[ $PV == *9999* ]]; then
	KEYWORDS=""
else
	SRC_URI="mirror://kde/stable/${PN}/${PV}/src/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="A LL(1) parser generator used mainly by KDevelop language plugins"
LICENSE="LGPL-2"
SLOT="0"
IUSE="debug"

RDEPEND=""
DEPEND="
	sys-devel/bison
	sys-devel/flex
"
