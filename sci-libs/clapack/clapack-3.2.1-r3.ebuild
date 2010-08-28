# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit eutils cmake-utils

DESCRIPTION="f2c'ed version of LAPACK"
HOMEPAGE="http://www.netlib.org/clapack/"
SRC_URI="http://www.netlib.org/${PN}/${P}-CMAKE.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/libf2c-20081126[static-libs]
	virtual/blas"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/clapack-${PV}-CMAKE

src_prepare() {
	epatch "${FILESDIR}"/${P}-noblasf2c.patch

	sed \
		-e 's:"f2c.h":<f2c.h>:g' \
		-i SRC/*.c || die
}

src_configure() {
	mycmakeargs=( $(cmake-utils_use_enable test TESTS) )
	cmake-utils_src_configure
}
