# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DECLARATIVE_REQUIRED="always"
KDE_MINIMAL="4.10"
inherit kde4-base

DESCRIPTION="Application launcher for KDE Plasma desktop"
HOMEPAGE="https://projects.kde.org/projects/playground/base/homerun"
[[ ${PV} == *9999 ]] || SRC_URI="mirror://kde/unstable/${PN}/src/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1 BSD"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep libkworkspace)
"
RDEPEND="
	${DEPEND}
	$(add_kdebase_dep plasma-workspace)
"
