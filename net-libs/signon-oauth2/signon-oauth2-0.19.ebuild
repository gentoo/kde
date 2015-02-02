# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qmake-utils

SRC_URI="https://accounts-sso.googlecode.com/files/${P}.tar.bz2"
SLOT="0"
DESCRIPTION="OAuth2 plugin for Signon daemon"
HOMEPAGE="https://01.org/gsso/"

KEYWORDS="~amd64 ~x86"
LICENSE="LGPL-2.1"
IUSE="test"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtnetwork:5
	dev-qt/qttest:5
	net-libs/signond
"
RDEPEND="${DEPEND}"

src_prepare() {
	if use !test; then
		sed -i -e '/^SUBDIRS/s/tests//' signon-oauth2.pro || die "couldn't disable tests"
	else
		sed -i -e '/^INSTALLS.*/,+1d' tests/tests.pro || die "couldn't remove tests from install target"
	fi
}

src_configure() {
	eqmake5
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}
