# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kget/kget-4.2.1-r1.ebuild,v 1.1 2009/03/15 14:29:39 scarabeus Exp $

EAPI="2"

KMNAME="kdenetwork"
inherit kde4-meta

DESCRIPTION="An advanced download manager for KDE"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug +plasma bittorrent -bittorrent-external +semantic-desktop sqlite"

DEPEND="
	dev-libs/libpcre
	>=kde-base/kdelibs-${PV}:${SLOT}[kdeprefix=,semantic-desktop?]
	bittorrent? (
		app-crypt/qca:2
		dev-libs/gmp
	)
	bittorrent-external? ( >=net-p2p/ktorrent-3.1.5[kdeprefix=] )
	sqlite? ( dev-db/sqlite )
"
RDEPEND="${DEPEND}
	semantic-desktop? ( >=kde-base/nepomuk-${PV}:${SLOT}[kdeprefix=] )
"

pkg_setup() {
	if use bittorrent && use bittorrent-external; then
		echo
		eerror "USE flag 'bittorrent' conflicts with these USE flag 'bittorrent-external'"
		eerror
		eerror "You must disable these conflicting flags before you can emerge this package."
		eerror "You can do this by disabling one of these flags in /etc/portage/package.use:"
		eerror "    =${CATEGORY}/${PN}-${PV} -bittorrent-external"
		echo
		die "Conflicting USE flags found"
	fi

	kde4-base_pkg_setup
}

src_prepare() {
	if ! use bittorrent && ! use bittorrent-external; then
		sed -i -e '/bittorrent/s:^:#DONOTCOMPILE :' \
			"${S}"/kget/transfer-plugins/CMakeLists.txt \
			|| die "sed to disable torrent support failed."
	fi

	kde4-meta_src_prepare
}

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_enable bittorrent EMBEDDED_TORRENT_SUPPORT)
		$(cmake-utils_use_with plasma Plasma)
		$(cmake-utils_use_with semantic-desktop Nepomuk)
		$(cmake-utils_use_with semantic-desktop Soprano)
		$(cmake-utils_use_with sqlite Sqlite)"

	kde4-meta_src_configure
}
