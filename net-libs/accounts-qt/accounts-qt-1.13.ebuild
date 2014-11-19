# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qmake-utils

DESCRIPTION="Qt5 bindings for libaccounts-glib"
HOMEPAGE="https://01.org/gsso/"
SRC_URI="https://accounts-sso.googlecode.com/files/${PN}-1.11.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	net-libs/libaccounts-glib
	dev-libs/glib
	dev-qt/qtcore:5
	dev-qt/qttest:5
	dev-qt/qtxml:5
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-1.11"
src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.11-to-1.13.patch
	sed -i -e '/^SUBDIRS/s/tests//' accounts-qt.pro || die "couldn't disable tests"
}

src_configure() {
	eqmake5
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}
