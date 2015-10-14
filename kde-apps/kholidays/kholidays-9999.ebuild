# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_DOXYGEN="true"
KDE_TEST="true"
inherit kde5

DESCRIPTION="Library for determining holidays and other special events for a geographical region"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND=""

src_prepare() {
	sed -e "/find_package(Qt5 .*Test/ s/Test/Core/" -i CMakeLists.txt
	kde5_src_prepare
}
