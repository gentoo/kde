# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

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

S="${WORKDIR}/${P}/build/autotools"

src_prepare() {
	mkdir m4
	eautoreconf
}
