# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qmake-utils

SRC_URI="https://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.bz2"
SLOT="0"
DESCRIPTION="Signon UI"
HOMEPAGE="https://launchpad.net/signon-ui"

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2 GPL-3"
RESTRICT="test"

# libproxy[kde] results into segfaults
DEPEND="
	dev-libs/glib
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qttest:5
	dev-qt/qtwebkit:5
	dev-qt/qtwidgets:5
	net-libs/accounts-qt
	net-libs/signond
	net-libs/libproxy[-kde]
	x11-libs/libnotify
"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e '/^SUBDIRS.*/,+1d' tests/tests.pro  || die "couldn't disable tests"
}

src_configure() {
	eqmake5
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}
