# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdenetwork"
inherit kde4-meta

DESCRIPTION="An advanced download manager for KDE"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug +handbook +plasma +semantic-desktop sqlite"

DEPEND="
	app-crypt/qca:2
	dev-libs/gmp
	dev-libs/libpcre
	>=kde-base/kdelibs-${PV}:${SLOT}[kdeprefix=,semantic-desktop?]
	>=kde-base/libknotificationitem-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/libkonq-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/libkworkspace-${PV}:${SLOT}[kdeprefix=]
	sqlite? ( dev-db/sqlite:3 )
"
RDEPEND="${DEPEND}
	semantic-desktop? ( >=kde-base/nepomuk-${PV}:${SLOT}[kdeprefix=] )
"

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DENABLE_EMBEDDED_TORRENT_SUPPORT=ON
		$(cmake-utils_use_with plasma)
		$(cmake-utils_use_with semantic-desktop Nepomuk)
		$(cmake-utils_use_with semantic-desktop Soprano)
		$(cmake-utils_use_with sqlite)"

	kde4-meta_src_configure
}
