# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kleopatra/kleopatra-4.2.0.ebuild,v 1.2 2009/02/01 07:24:32 jmbsvicetto Exp $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="Kleopatra - KDE X.509 key manager"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug htmlhandbook"
#RESTRICT="test"

DEPEND="app-crypt/gnupg
	app-crypt/gpgme
	dev-libs/libassuan
	>=kde-base/libkleo-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="libkleo"
KMLOADLIBS="libkleo"

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DWITH_QGPGME=ON"

	kde4-meta_src_configure
}
