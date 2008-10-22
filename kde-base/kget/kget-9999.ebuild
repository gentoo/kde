# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdenetwork
inherit kde4svn-meta

DESCRIPTION="An advanced download manager for KDE"
KEYWORDS=""
IUSE="debug htmlhandbook +plasma bittorrent semantic-desktop sqlite"

DEPEND="
	dev-libs/libpcre
	plasma? ( kde-base/libplasma:${SLOT} )
	semantic-desktop? ( >=kde-base/nepomuk-${PV}:${SLOT} )
	sqlite? ( dev-db/sqlite )
	bittorrent? ( dev-libs/gmp net-p2p/ktorrent:${SLOT} )"
RDEPEND="${DEPEND}"

src_compile() {
	if ! use bittorrent; then
		sed -i -e '/bittorrent/s:^:#DONOTCOMPILE :' \
			"${S}"/kget/transfer-plugins/CMakeLists.txt \
			|| die "sed to disable torrent support failed."
	fi

	mycmakeargs="${mycmakeargs} -DWITH_Xmms=OFF
		$(cmake-utils_use_with plasma Plasma)
		$(cmake-utils_use_with semantic-desktop Nepomuk)
		$(cmake-utils_use_with semantic-desktop Soprano)
		$(cmake-utils_use_with sqlite Sqlite)"

	kde4overlay-meta_src_compile
}
