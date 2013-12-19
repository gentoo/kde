# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

FRAMEWORKS_DOXYGEN="true"
KMNAME="${PN}-framework"
inherit kde-frameworks

DESCRIPTION="Library for handling the DNS-SD layer of Zeroconf"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE="zeroconf"

RDEPEND="
	$(add_frameworks_dep kconfig)
	dev-qt/qtnetwork:5
	zeroconf? (
		dev-qt/qtdbus:5
		net-dns/avahi[mdnsresponder-compat]
	)
"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package zeroconf Avahi)
	)

	kde-frameworks_src_configure
}
