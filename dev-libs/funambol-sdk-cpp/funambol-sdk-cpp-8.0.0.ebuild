# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils autotools

DESCRIPTION="Funambol Client SDK, C++ part only"
HOMEPAGE="https://www.forge.funambol.org/download/"

SRC_URI="http://dev.gentooexperimental.org/~dreeevil/funambol-sdk-cpp-8.0.0.tar.bz2"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	cd "${S}/build/autotools"
	eautoreconf || die "Failed to autotoolize"
}

src_compile() {
	cd "${S}/build/autotools"
	emake || die "Failed to compilerize"
}

src_install() {
	cd "${S}/build/autotools"
	emake DESTDIR="${D}" install || die "Failed to installerize"
}
