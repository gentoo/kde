# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

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

S="${WORKDIR}/${P}/build/autotools"

src_prepare() {
	eautoreconf
}
