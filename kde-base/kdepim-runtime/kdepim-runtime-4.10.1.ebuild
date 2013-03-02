# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KMNAME="kdepim-runtime"
inherit kde4-base

DESCRIPTION="KDE PIM runtime plugin collection"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug google kolab"

RESTRICT="test"
# Would need test programs _testrunner and akonaditest from kdepimlibs, see bug 313233

DEPEND="
	app-misc/strigi
	>=app-office/akonadi-server-1.9.0
	dev-libs/boost
	dev-libs/libxml2:2
	dev-libs/libxslt
	>=dev-libs/shared-desktop-ontologies-0.10.0
	$(add_kdebase_dep kdepimlibs 'semantic-desktop')
	x11-misc/shared-mime-info
	google? ( >=net-libs/libkgapi-0.4.3[-oldpim] )
	kolab? ( net-libs/libkolab )
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kdepim-icons)
	!kde-misc/akonadi-google
"

# nepomuk_email_feeder moved here in 4.8
add_blocker kdepim-common-libs 4.7.50

src_prepare() {
	sed -e "s:find_package(LibKGAPI QUIET NO_MODULE):macro_optional_find_package(LibKGAPI):g" \
	    -i "${S}/CMakeLists.txt" || die "fixing automagic dependencies failed"

	kde4-base_src_prepare
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with google LibKGAPI)
		$(cmake-utils_use_with kolab Libkolab)
	)

	kde4-base_src_configure
}
