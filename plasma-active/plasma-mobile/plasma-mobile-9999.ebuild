# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base
DESCRIPTION="Plasma shell optimized for mobile devices"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2 LGPL-2 LGPL-2.1"
SLOT="4"
KEYWORDS=""
IUSE="handset"

DEPEND="
	!kde-base/libkworkspace
	dev-libs/soprano
	$(add_kdebase_dep kactivities)
	$(add_kdebase_dep kdepimlibs)
	$(add_kdebase_dep nepomuk-core)
	net-libs/libnm-qt
	x11-libs/libkscreen
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use handset BUILD_HANDSET)
	)
	kde4-base_src_configure
}
