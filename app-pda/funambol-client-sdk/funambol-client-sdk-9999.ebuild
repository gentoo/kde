# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit autotools subversion

DESCRIPTION="Funambol Client SDK"
HOMEPAGE="https://www.forge.funambol.org/download/"
ESVN_REPO_URI="https://client-sdk.forge.funambol.org/svn/client-sdk/trunk/cpp-sdk"
ESVN_USER="guest"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="net-misc/curl"
RDEPEND="${DEPEND}"

src_prepare() {
	cd "${S}"/build/autotools
	mkdir m4
	eautoreconf
}

src_configure() {
	cd "${S}"/build/autotools
	econf || die "configure failed"
}

src_install() {
	cd "${S}"/build/autotools
	emake DESTDIR="${ED}" install || die "emake install failed"
}
