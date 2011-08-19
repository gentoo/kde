# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

MY_PN="${PN}"-core
MY_P="${MY_PN}"-"${PV}"

inherit cmake-utils

DESCRIPTION="High-performance, full-featured text search engine based off of lucene in C++"
HOMEPAGE="http://clucene.sourceforge.net/"
SRC_URI="mirror://sourceforge/clucene/${MY_P}.tar.gz"

LICENSE="|| ( Apache-2.0 LGPL-2.1 )"
SLOT="1"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd
~amd64-linux ~x86-linux ~ppc-macos"

IUSE="debug doc static-libs"

DEPEND="
	doc? ( >=app-doc/doxygen-1.4.2 )
"
RDEPEND="!<app-misc/strigi-0.7.5-r3"

DOCS=(AUTHORS ChangeLog README README.PACKAGE REQUESTS)

PATCHES=(
	"${FILESDIR}/${PN}-9999-cmake.patch"
)

S="${WORKDIR}/${MY_PN}-${PV}"

src_configure() {
	# Disabled threads: see upstream bug
	# https://sourceforge.net/tracker/?func=detail&aid=3237301&group_id=80013&atid=558446 
	local mycmakeargs=(
		-DENABLE_ASCII_MODE=OFF
		-DENABLE_PACKAGING=OFF
		-DDISABLE_MULTITHREADING=OFF
		$(cmake-utils_use_enable debug)
		$(cmake-utils_use_enable doc CLDOCS)
		$(cmake-utils_use_build static-libs STATIC_LIBRARIES)
	)

	cmake-utils_src_configure
}
