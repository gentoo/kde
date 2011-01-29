# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

QT_DEPEND="4.6.3"
inherit cmake-utils virtualx

if [[ "${PV}" = 9999* ]] ; then
	inherit git

	EGIT_REPO_URI="git://gitorious.org/dbusmenu/dbusmenu-qt.git"

	KEYWORDS=""
else
	# We are using snapshots from Aurelien's repos, as advised in kde-packager ml
	# This is because version 0.6.3 removed code from the official version,
	#  because Canonical has no copyright on it
	#SRC_URI="mirror://gentoo/${P}.tar.bz2"
	SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.bz2"

	KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
fi

DESCRIPTION="A library providing Qt implementation of DBusMenu specification"
HOMEPAGE="https://launchpad.net/libdbusmenu-qt/"

LICENSE="LGPL-2"
SLOT="0"
IUSE="debug"

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
	mycmakeargs=(
		$(cmake-utils_use_build test TESTS)
	)
	cmake-utils_src_configure
}

src_test() {
	pushd "${CMAKE_BUILD_DIR}/tests" > /dev/null
	local ctestargs
	[[ -n ${TEST_VERBOSE} ]] && ctestargs="--extra-verbose --output-on-failure"

	export maketype="ctest ${ctestargs}"
	virtualmake || die "Tests failed."

	popd > /dev/null
}
