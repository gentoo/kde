# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base
DESCRIPTION="A content publishing and distribution platform for Plasma Active"
HOMEPAGE="http://www.kde.org/"
SRC_URI="mirror://kde/stable/active/4.0/src/${P}.tar.xz"

LICENSE="GPL-2+ LGPL-2+"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="epub"

DEPEND="
	dev-libs/qjson
	epub? ( dev-libs/soprano $(add_kdebase_dep nepomuk-core epub) )
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		"-DCMAKE_DISABLE_FIND_PACKAGE_Soprano=FALSE"
		$(cmake-utils_use_find_package epub Soprano)
		$(cmake-utils_use_find_package epub NepomukCore)
	)
	kde4-base_src_configure
}
