# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME="extragear/network"
NEED_KDE="svn"

inherit kde4svn-meta flag-o-matic

DESCRIPTION="A graphical FTP client for KDE."
HOMEPAGE="http://www.kftp.org"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="kde-svn"
IUSE="htmlhandbook"

DEPEND="net-libs/libssh2
	dev-libs/openssl"
RDEPEND="${DEPEND}"

src_compile() {
	append-ldflags -Wl,--no-as-needed

	kde4overlay-base_src_compile
}
