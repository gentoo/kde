# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDEBASE="kdevelop"
inherit kde5

DESCRIPTION="LL(1) parser generator used mainly by KDevelop language plugins"
LICENSE="LGPL-2"
IUSE=""
[[ ${KDE_BUILD_TYPE} = release ]] && KEYWORDS="~amd64 ~x86"

DEPEND="
	sys-devel/bison
	sys-devel/flex
"
RDEPEND="
	!dev-util/kdevelop-pg-qt:4
"
