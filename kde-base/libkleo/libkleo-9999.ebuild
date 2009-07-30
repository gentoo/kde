# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="KDE library for encryption handling."
KEYWORDS=""
IUSE="debug"

DEPEND="
	>=kde-base/kdepimlibs-${PV}:${SLOT}[kdeprefix=]
"
RDEPEND="${DEPEND}
	app-crypt/gnupg
"

KMSAVELIBS="true"
KMEXTRACTONLY="kleopatra/"

src_configure() {
	mycmakeargs="${mycmakeargs} -DWITH_QGPGME=ON"

	kde4-meta_src_configure
}
