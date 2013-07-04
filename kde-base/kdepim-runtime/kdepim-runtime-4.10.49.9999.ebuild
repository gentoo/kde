# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KMNAME="kdepim-runtime"
inherit kde4-base

DESCRIPTION="KDE PIM runtime plugin collection"
KEYWORDS=""
IUSE="debug google kolab"

RESTRICT="test"
# Would need test programs _testrunner and akonaditest from kdepimlibs, see bug 313233

DEPEND="
	app-misc/strigi
	>=app-office/akonadi-server-1.9.0
	dev-libs/boost:=
	dev-libs/libxml2:2
	dev-libs/libxslt
	>=dev-libs/shared-desktop-ontologies-0.10.0
	$(add_kdebase_dep kdepimlibs 'semantic-desktop(+)')
	x11-misc/shared-mime-info
	google? ( >=net-libs/libkgapi-0.4.3 )
	kolab? ( net-libs/libkolab )
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kdepim-icons)
	!kde-misc/akonadi-google
"

src_configure() {
	epatch "${FILESDIR}/${PN}-4.10.5-fix-autoconfig.patch"
	local mycmakeargs=(
		$(cmake-utils_use_find_package google LibKGAPI)
		$(cmake-utils_use_find_package kolab Libkolab)
		$(cmake-utils_use_find_package kolab Libkolabxml)
	)

	kde4-base_src_configure
}
