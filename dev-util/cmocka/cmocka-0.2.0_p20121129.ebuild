# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils
DESCRIPTION="The lightweight C unit testing library"
HOMEPAGE="https://open.cryptomilk.org/projects/cmocka"
SRC_URI="http://dev.gentoo.org/~creffett/distfiles/${P}.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc static-libs"

DEPEND="
	doc? ( app-doc/doxygen[latex] )
"
RDEPEND=""

PATCHES=( "${FILESDIR}/${PN}-automagicness.patch" )

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with static-libs STATIC_LIB)
		$(cmake-utils_use test UNIT_TESTING)
		$(cmake-utils_use_with doc APIDOC)
	)
	cmake-utils_src_configure
}
