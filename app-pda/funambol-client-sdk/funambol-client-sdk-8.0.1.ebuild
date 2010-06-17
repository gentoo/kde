# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=2

inherit autotools

DESCRIPTION="Funambol Client SDK"
HOMEPAGE="https://www.forge.funambol.org/download/"
SRC_URI="http://download.forge.objectweb.org/sync4j/${P}.zip"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="net-misc/curl"
RDEPEND="${DEPEND}"
S="${WORKDIR}"/Funambol/sdk/cpp/build/autotools

src_prepare() {
	epatch "${FILESDIR}"/"${PN}"-fireevent.patch
	eautoreconf
}

src_configure() {
	econf || die "configure failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
