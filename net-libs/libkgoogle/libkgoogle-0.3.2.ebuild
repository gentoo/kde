# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_SCM="git"
inherit kde4-base

DESCRIPTION="Library for accessing various Google services based on KDE Platform"
HOMEPAGE="http://progdan.cz/category/akonadi-google/"
SRC_URI="mirror://kde/stable/${PN}/${PV}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="oldpim"

DEPEND="
	$(add_kdebase_dep kdepimlibs semantic-desktop)
	dev-libs/libxslt
	dev-libs/qjson
	oldpim? ( dev-libs/boost )
	!oldpim? ( $(add_kdebase_dep kdepimlibs semantic-desktop 4.6.0) )
"
RDEPEND="${DEPEND}
	!kde-misc/akonadi-google
"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use oldpim KCAL)
	)
	kde4-base_src_configure
}
