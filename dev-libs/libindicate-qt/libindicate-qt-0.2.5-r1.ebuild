# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit virtualx cmake-utils

DESCRIPTION="Qt wrapper for libindicate library"
HOMEPAGE="https://launchpad.net/libindicate-qt/"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.bz2"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	x11-libs/qt-gui:4
	>=dev-libs/libindicate-0.3.3
	<dev-libs/libindicate-0.4.50
"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
"

src_test() {
	local ctestargs
	[[ -n ${TEST_VERBOSE} ]] && ctestargs="--extra-verbose --output-on-failure"

	cd "${CMAKE_BUILD_DIR}/tests"

	export maketype="ctest ${ctestargs}"
	virtualmake || die "Tests failed."
}
