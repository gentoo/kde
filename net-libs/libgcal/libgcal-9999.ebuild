# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils git autotools

DESCRIPTION="C/C++ interface to the Google Data API"
HOMEPAGE="http://code.google.com/p/libgcal/"
EGIT_REPO_URI="git://repo.or.cz/libgcal.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="curldebug debug"

DEPEND=">=dev-libs/libxml-1.8.17-r2
	    >=net-misc/curl-7.18.2"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf -i -f || die "eautoreconf failed"
}

src_configure() {
	local myconf="$(use_enable debug) \
		$(use_enable curldebug)"

	econf ${myconf}
}


src_install() {
	einstall || die "einstall failed"
}
