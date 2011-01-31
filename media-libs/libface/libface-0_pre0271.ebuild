# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit cmake-utils

DESCRIPTION="Face recognition library"
HOMEPAGE="http://libface.sourceforge.net/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT=0
IUSE="doc examples"

RDEPEND="media-libs/opencv"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
"

S=${WORKDIR}/${PN}

src_configure() {
	mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		$(cmake-utils_use_build doc DOCUMENTATION)
		$(cmake-utils_use_build examples)
		-DBUILD_EXAMPLES_GUI=OFF
	)
	cmake-utils_src_configure
}
