# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

#inherit eutils git autotools
inherit cmake-utils

DESCRIPTION="C/C++ interface to the Google Data API"
HOMEPAGE="http://code.google.com/p/libgcal/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="curldebug test"

DEPEND="
	dev-libs/libxml2:2
	>=net-misc/curl-7.18.2
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_enable test TESTS)
		$(cmake-utils_use curldebug CURL_DEBUG)
	)

	cmake-utils_src_configure
}
