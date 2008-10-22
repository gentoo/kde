# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

inherit git qt4

EGIT_REPO_URI="git://git.kernel.org/pub/scm/qgit/qgit4.git"
CPPUNIT_REQUIRED="optional"

DESCRIPTION="GUI interface for git/cogito SCM"
HOMEPAGE="http://digilander.libero.it/mcostalba/"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS=""
IUSE=""

DEPEND="|| ( x11-libs/qt-gui:4 =x11-libs/qt-4.4*:4 )"
RDEPEND="${DEPEND}
	>=dev-util/git-1.5.3"

src_compile() {
	eqmake4 || die "eqmake failed"
	emake || die "emake failed"
}

src_install() {
	newbin bin/qgit qgit4
	dodoc README
}

pkg_postinst() {
	elog "This is installed as qgit4 now so you can still use 1.5 series (Qt3-based)"
}
