# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdenetwork"
inherit kde4-meta

DESCRIPTION="An advanced download manager for KDE"
KEYWORDS=""
IUSE="debug +handbook +plasma bittorrent-external +semantic-desktop sqlite"

DEPEND="
	dev-libs/libpcre
	>=kde-base/kdelibs-${PV}:${SLOT}[kdeprefix=,semantic-desktop?]
	>=kde-base/libkonq-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/libkworkspace-${PV}:${SLOT}[kdeprefix=]
	bittorrent-external? ( >=net-p2p/ktorrent-3.1.5 )
	!bittorrent-external? (
		app-crypt/qca:2
		dev-libs/gmp
	)
	sqlite? ( dev-db/sqlite:3 )
"
RDEPEND="${DEPEND}
	semantic-desktop? ( >=kde-base/nepomuk-${PV}:${SLOT}[kdeprefix=] )
"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_enable !bittorrent-external EMBEDDED_TORRENT_SUPPORT)
		$(cmake-utils_use_with plasma)
		$(cmake-utils_use_with semantic-desktop Nepomuk)
		$(cmake-utils_use_with semantic-desktop Soprano)
		$(cmake-utils_use_with sqlite)"

	kde4-meta_src_configure
}
