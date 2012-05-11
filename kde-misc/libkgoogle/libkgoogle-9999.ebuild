# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_SCM="git"
inherit kde4-base

DESCRIPTION="KDE-based library for accessing various Google services"
HOMEPAGE="http://progdan.cz/category/akonadi-google/"
LICENSE="GPL-3"

SLOT="4"
KEYWORDS=""
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
