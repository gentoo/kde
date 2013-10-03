# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base
DESCRIPTION="Plasma shell optimized for mobile devices"
HOMEPAGE="http://www.kde.org/"
#SRC_URI="mirror://kde/stable/active/4.0/src/${P}.tar.xz"
SRC_URI="http://dev.gentoo.org/~creffett/distfiles/${P}.tar.xz"

LICENSE="GPL-2 LGPL-2 LGPL-2.1"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="handset"

DEPEND="
	dev-libs/soprano
	$(add_kdebase_dep kactivities)
	$(add_kdebase_dep kdepimlibs)
	$(add_kdebase_dep nepomuk-core)
	net-libs/libnm-qt
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-0.5-solidinherit.patch"
)

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use handset BUILD_HANDSET)
	)
	kde4-base_src_configure
}
