# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/arora/arora-0.3.ebuild,v 1.1 2008/08/05 05:32:04 yngwin Exp $

EAPI=1
inherit eutils qt4 git

DESCRIPTION="A cross-platform Qt4 WebKit browser"
HOMEPAGE="http://arora.googlecode.com/"
EGIT_REPO_URI="git://github.com/Arora/arora.git"

LICENSE="|| ( GPL-3 GPL-2 )"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=">=x11-libs/qt-webkit-4.4.0:4"
DEPEND="${RDEPEND}"

src_compile() {
	eqmake4 arora.pro PREFIX="${D}/usr" || die "qmake failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog README
}
