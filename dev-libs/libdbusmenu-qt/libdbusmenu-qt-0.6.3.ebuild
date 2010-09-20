# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libdbusmenu-qt/libdbusmenu-qt-0.6.2.ebuild,v 1.3 2010/09/19 02:16:11 abcd Exp $

EAPI="3"

QT_DEPEND="4.6.3"
inherit cmake-utils

DESCRIPTION="A library providing Qt implementation of DBusMenu specification"
HOMEPAGE="https://launchpad.net/libdbusmenu-qt/"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.bz2"

LICENSE="LGPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
SLOT="0"
IUSE="debug test"

# Bug #315215, require X server running
RESTRICT="test"

RDEPEND="
	>=x11-libs/qt-core-${QT_DEPEND}:4
	>=x11-libs/qt-gui-${QT_DEPEND}:4[dbus]
"
DEPEND="${RDEPEND}
	test? (
		dev-libs/qjson
		>=x11-libs/qt-test-${QT_DEPEND}:4
	)
"

DOCS=(NEWS README)

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_build test TESTS)
	)
	cmake-utils_src_configure
}
