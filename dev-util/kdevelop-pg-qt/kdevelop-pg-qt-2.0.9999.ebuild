# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGIT_BRANCH="2.0"
KDEBASE="kdevelop"
inherit kde5

if [[ ${KDE_BUILD_TYPE} = release ]]; then
	SRC_URI="mirror://kde/stable/${PN}/${PV}/src/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="LL(1) parser generator used mainly by KDevelop language plugins"
LICENSE="LGPL-2"
IUSE=""

DEPEND="
	sys-devel/bison
	sys-devel/flex
"
RDEPEND="
	!dev-util/kdevelop-pg-qt:4
"
