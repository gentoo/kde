# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils git-2

DESCRIPTION="Extra modules and scripts for CMake"
HOMEPAGE="http://www.kde.org/"
EGIT_REPO_URI="git://anongit.kde.org/${PN}"

LICENSE="BSD"
SLOT=0
KEYWORDS=""

DEPEND="
	>=dev-util/cmake-2.8.11
"
RESTRICT="test"

src_prepare() {
	sed -e 's|man/man7|share/&|' -i CMakeLists.txt || die
	cmake-utils_src_prepare
}
