# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdenetwork"
inherit kde4-meta

DESCRIPTION="An advanced download manager for KDE"
KEYWORDS=""
IUSE="debug doc +plasma bittorrent bittorrent-external +semantic-desktop sqlite"

DEPEND="
	dev-libs/libpcre
	>=kde-base/kdelibs-${PV}:${SLOT}[kdeprefix=,semantic-desktop?]
	>=kde-base/libkonq-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/libkworkspace-${PV}:${SLOT}[kdeprefix=]
	bittorrent? (
		app-crypt/qca:2
		dev-libs/gmp
	)
	bittorrent-external? ( >=net-p2p/ktorrent-3.1.5 )
	sqlite? ( dev-db/sqlite:3 )
"
RDEPEND="${DEPEND}
	semantic-desktop? ( >=kde-base/nepomuk-${PV}:${SLOT}[kdeprefix=] )
"

src_prepare() {
	if ! use bittorrent && ! use bittorrent-external; then
		sed -i -e '/bittorrent/s:^:#DONOTCOMPILE :' \
			kget/transfer-plugins/CMakeLists.txt \
			|| die "sed to disable torrent support failed."
		sed -i -e 's|application/x-bittorrent;||' \
			kget/desktop/kget.desktop \
			|| die "sed to disable torrent mime-type handling failed."
	fi

	kde4-meta_src_prepare
}

src_configure() {
	if use bittorent-external && use bittorent ; then
		einfo "Using the external plugin."
		einfo "Disable bittorent-external useflag if you want iternal one."
	fi
	if use bittorent-external; then
		mycmakeargs="${mycmakeargs} -DEMBEDDED_TORRENT_SUPPORT=OFF"
	else
		mycmakeargs="${mycmakeargs}
			$(cmake-utils_use_enable bittorrent EMBEDDED_TORRENT_SUPPORT)"
	fi
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with plasma)
		$(cmake-utils_use_with semantic-desktop Nepomuk)
		$(cmake-utils_use_with semantic-desktop Soprano)
		$(cmake-utils_use_with sqlite)"

	kde4-meta_src_configure
}
