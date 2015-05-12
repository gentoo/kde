# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MY_PN="signon"
MY_P="${MY_PN}-${PV}"
inherit qmake-utils

DESCRIPTION="Signon daemon for libaccounts-glib"
HOMEPAGE="https://01.org/gsso/"
SRC_URI="http://dev.gentoo.org/~kensington/distfiles/${MY_P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

RESTRICT="test"

# libproxy[kde] results to segfaults
RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtsql:5
	net-libs/libproxy[-kde]
"
DEPEND="${DEPEND}
	doc? ( app-doc/doxygen )
"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	if use !test; then
		sed -i -e '/^SUBDIRS/s/tests//' signon.pro || die "couldn't disable tests"
	fi
	use doc || sed -e "/include( doc\/doc.pri )/d" -i ${MY_PN}.pro || die
}

src_configure() {
	eqmake5
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}
