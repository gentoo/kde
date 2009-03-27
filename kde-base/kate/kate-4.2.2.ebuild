# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kate/kate-4.2.1.ebuild,v 1.4 2009/03/15 14:20:07 scarabeus Exp $

EAPI="2"

KMNAME="kdesdk"
inherit kde4-meta

DESCRIPTION="Kate is an MDI texteditor."
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug +plasma"

DEPEND="
	dev-libs/libxml2
	dev-libs/libxslt
"
RDEPEND="${DEPEND}"

KMEXTRA="doc/kate-plugins"

src_prepare() {
	# Disable hardcoded kdepimlibs check - only 4.2 branch is affected
	sed -i -e 's/find_package(KdepimLibs REQUIRED)/macro_optional_find_package(KdepimLibs)/' \
		CMakeLists.txt || die "failed to disable kdepimlibs hardcoded check"

	kde4-meta_src_prepare
}

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with plasma Plasma)"

	kde4-meta_src_configure
}
