# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdepim
inherit kde4svn-meta

DESCRIPTION="Kleopatra - KDE X.509 key manager"
KEYWORDS=""
IUSE="debug htmlhandbook"
RESTRICT="test"

DEPEND="app-crypt/gnupg
	app-crypt/gpgme
	dev-libs/libassuan
	>=kde-base/libkleo-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="libkleo"
KMLOADLIBS="libkleo"

src_compile() {
	mycmakeargs="${mycmakeargs}
		-DWITH_QGpgme=ON"

	kde4overlay-meta_src_compile
}
