# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit kde4-base

DESCRIPTION="Advanced Kolab Object Handling Library"
HOMEPAGE="kolab.org"
SRC_URI="http://git.kolab.org/${PN}/snapshot/${P}.tar.gz"

LICENSE="GPL-2 GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="test"

PATCHES=( "${FILESDIR}/libkolab-fix-include.patch" )

DEPEND="
	$(add_kdebase_dep kmimetypefinder)
	$(add_kdebase_dep kabcclient)
	app-office/akonadi-server
	>=kde-misc/libkolabxml-0.4.0
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with test BUILD_TESTS)
	)
	kde4-base_src_configure
}
