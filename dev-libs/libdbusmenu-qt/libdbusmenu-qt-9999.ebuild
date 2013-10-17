# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EBZR_REPO_URI="lp:libdbusmenu-qt"

[[ ${PV} == 9999* ]] && BZR_ECLASS="bzr"
inherit cmake-utils virtualx ${BZR_ECLASS}

DESCRIPTION="A library providing Qt implementation of DBusMenu specification"
HOMEPAGE="https://launchpad.net/libdbusmenu-qt/"
if [[ ${PV} == 9999* ]] ; then
	KEYWORDS=""
else
	#SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.bz2"
	# upstream has no permissions to use some kde written code so repack git
	# repo every time
	SRC_URI="http://dev.gentoo.org/~scarabeus/${P}.tar.xz"
	KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-fbsd ~amd64-linux ~x86-linux"
fi

LICENSE="LGPL-2"
SLOT="0"
IUSE="debug doc"

RDEPEND="
	dev-qt/qtcore:4
	dev-qt/qtdbus:4
	dev-qt/qtgui:4
"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	test? (
		dev-libs/qjson
		dev-qt/qttest:4
	)
"

DOCS=( NEWS README )
PATCHES=( "${FILESDIR}/${PN}-0.9.2-optionaltests.patch" )

# tests fail due to missing conection to dbus
RESTRICT="test"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_build test TESTS)
		$(cmake-utils_use_with doc)
	)
	cmake-utils_src_configure
}

src_test() {
	local builddir=${BUILD_DIR}

	BUILD_DIR=${BUILD_DIR}/tests \
		VIRTUALX_COMMAND=cmake-utils_src_test virtualmake

	BUILD_DIR=${builddir}
}
