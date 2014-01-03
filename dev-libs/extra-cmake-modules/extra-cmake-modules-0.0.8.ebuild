# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils git-r3

DESCRIPTION="Extra modules and scripts for CMake"
HOMEPAGE="https://projects.kde.org/projects/kdesupport/extra-cmake-modules"
EGIT_REPO_URI=( "git://anongit.kde.org/${PN}" )
EGIT_COMMIT="cc628694c9e55ffb38fad6e8bfc071fa4e09609b"

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
