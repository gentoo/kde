# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit cmake-utils git

DESCRIPTION="QT-style Interface for libinfinity"
HOMEPAGE="http://kobby.greghaynes.net/wiki/libqinfinity"
EGIT_REPO_URI="git://github.com/greghaynes/libqinfinity"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="net-libs/libinfinity"

#temporary ugly thing till i patched the buildsystem
src_compile() {
CMAKE_IN_SOURCE_BUILD=1 cmake-utils_src_compile
}
