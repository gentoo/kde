# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

if [[ $PV != *9999 ]]; then
	KMNAME="kdenetwork"
	KDE_ECLASS=meta
else
	KDE_ECLASS=base
fi

KDE_HANDBOOK="optional"
inherit kde4-${KDE_ECLASS}

DESCRIPTION="An advanced download manager for KDE"
KEYWORDS=""
IUSE="debug bittorrent mms semantic-desktop sqlite webkit"

RDEPEND="
	app-crypt/qca:2
	$(add_kdebase_dep kdelibs 'semantic-desktop(+)?')
	$(add_kdebase_dep kdepimlibs)
	$(add_kdebase_dep libkonq)
	$(add_kdebase_dep libkworkspace)
	$(add_kdebase_dep solid)
	bittorrent? ( >=net-libs/libktorrent-1.0.3 )
	mms? ( media-libs/libmms )
	sqlite? ( dev-db/sqlite:3 )
	webkit? ( >=kde-misc/kwebkitpart-0.9.6 )
"
DEPEND="${RDEPEND}
	dev-libs/boost
"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with bittorrent KTorrent)
		$(cmake-utils_use_with mms LibMms)
		$(cmake-utils_use_with semantic-desktop Nepomuk)
		$(cmake-utils_use_with semantic-desktop Soprano)
		$(cmake-utils_use_with sqlite)
		$(cmake-utils_use_with webkit KWebKitPart)
	)
	kde4-${KDE_ECLASS}_src_configure
}
