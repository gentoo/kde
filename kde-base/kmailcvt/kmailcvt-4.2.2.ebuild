# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmailcvt/kmailcvt-4.2.1-r1.ebuild,v 1.1 2009/03/15 14:31:57 scarabeus Exp $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="KMail Import Filters"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

DEPEND="
	app-crypt/gpgme
"
RDEPEND="${DEPEND}
	app-crypt/gnupg
"

# xml targets from kmail are being uncommented by kde4-meta.eclass
KMEXTRACTONLY="
	kmail/
"

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DWITH_QGpgme=ON"

	kde4-meta_src_configure
}
