# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="Kleopatra - KDE X.509 key manager"
KEYWORDS=""
IUSE="debug htmlhandbook"
#RESTRICT="test"

DEPEND="
	app-crypt/gnupg
	app-crypt/gpgme
	dev-libs/libassuan
	>=kde-base/libkleo-${PV}:${SLOT}
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="libkleo"

KMLOADLIBS="libkleo"

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DWITH_QGPGME=ON"

	kde4-meta_src_configure
}
