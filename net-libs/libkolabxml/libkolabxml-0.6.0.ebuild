# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils

DESCRIPTION="Kolab XML format schema definitions library"
HOMEPAGE="http://www.kolab.org"
SRC_URI="http://dev.gentoo.org/~creffett/distfiles/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="csharp java python php test"

RDEPEND="
	dev-cpp/xsd
	|| ( >=dev-libs/boost-1.42.0 ( <dev-libs/boost-1.42.0 dev-libs/ossp-uuid ) )
	dev-libs/xerces-c
"
DEPEND="
	${RDEPEND}
	csharp? ( dev-lang/swig )
	java? ( dev-lang/swig )
	php? ( dev-lang/swig )
	python? ( dev-lang/swig )
	test? ( x11-libs/qt-test:4 )
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use csharp CSHARP_BINDINGS)
		$(cmake-utils_use java JAVA_BINDINGS)
		$(cmake-utils_use python PYTHON_BINDINGS)
		$(cmake-utils_use php PHP_BINDINGS)
		$(cmake-utils_use_build test TESTS)
	)
	cmake-utils_src_configure
}
