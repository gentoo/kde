# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

DESCRIPTION="Extra modules and scripts for CMake"
HOMEPAGE="http://www.kde.org/"

LICENSE="BSD"
SLOT=0
KEYWORDS=""
IUSE="debug"

RESTRICT="test"

src_prepare() {
	kde4-base_src_prepare

	sed -e 's|man/man7|share/&|' -i CMakeLists.txt || die
}
