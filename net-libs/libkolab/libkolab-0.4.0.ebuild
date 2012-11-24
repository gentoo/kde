# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libkolab/libkolab-0.3.2.ebuild,v 1.2 2012/10/17 18:57:30 maekke Exp $

EAPI=4

inherit kde4-base

DESCRIPTION="Advanced Kolab Object Handling Library"
HOMEPAGE="kolab.org"
SRC_URI="http://mirror.kolabsys.com/pub/releases/${P}.tar.gz"

LICENSE="LGPL-2+ LGPL-2.1+ LGPL-3+"
SLOT="4"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="php python test"

#Tests fail as of 0.3.2
RESTRICT="test"

DEPEND="
	$(add_kdebase_dep kdepimlibs)
	dev-lang/swig
	>=net-libs/libkolabxml-0.7.0
	php? ( dev-lang/php )
	python? ( dev-lang/python )

"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with test BUILD_TESTS)
		$(cmake-utils_use python PYTHON_BINDINGS)
		$(cmake-utils_use php PHP_BINDINGS)
	)
	kde4-base_src_configure
}
