# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME=kdepim
inherit kde4-meta

DESCRIPTION="KMail Import Filters"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="app-crypt/gnupg
	app-crypt/gpgme"
RDEPEND="${DEPEND}"

# xml targets from kmail are being uncommented by kde4-meta.eclass
KMEXTRACTONLY="kmail/"

src_compile() {
	mycmakeargs="${mycmakeargs}
		-DWITH_QGpgme=ON"

	kde4-meta_src_compile
}
