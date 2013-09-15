# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

if [[ ${KDE_BUILD_TYPE} != live ]]; then
	MY_PN=${PN}-kde
	MY_P=${MY_PN}-${PV}
	SRC_URI="mirror://kde/unstable/${PN}/${PV}/src/${MY_P}.tar.xz"
	KEYWORDS="~amd64"
else
	EGIT_REPO_URI="git://anongit.kde.org/kdeconnect-kde"
	KEYWORDS=""
fi

DESCRIPTION="Adds communication between KDE and your smartphone"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2+"
SLOT="4"
IUSE=""

DEPEND="$(add_kdebase_dep kdelibs )
	app-crypt/qca:2
	dev-libs/qjson
	dev-qt/qtdbus"
RDEPEND="${DEPEND}
	net-dns/avahi
"

S=${WORKDIR}/${MY_P}

src_prepare(){
	sed -i -e "s:QtCrypto/QtCrypto:QtCrypto:" kded/networkpackage.cpp || die
	kde4-base_src_prepare
}

pkg_postinst(){
	einfo
	einfo "The Android .apk file is available via"
	einfo "https://play.google.com/store/apps/details?id=org.kde.kdeconnect_tp"
	einfo
}
