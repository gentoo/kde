# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )
EGIT_REPO_URI=( "git://anongit.freedesktop.org/telepathy/${PN}" )
inherit base python-any-r1 cmake-utils virtualx git-r3 multibuild

DESCRIPTION="Qt4 bindings for the Telepathy D-Bus protocol"
HOMEPAGE="http://telepathy.freedesktop.org/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="debug farstream +qt4 qt5 test"

RDEPEND="
	farstream? (
		>=net-libs/telepathy-farstream-0.2.2
		>=net-libs/telepathy-glib-0.18.0
	)
	qt4? (
		dev-qt/qtcore:4
		dev-qt/qtdbus:4
	)
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtdbus:5
		dev-qt/qtgui:5
		dev-qt/qtnetwork:5
		dev-qt/qtxml:5
	)
	!net-libs/telepathy-qt4
"
DEPEND="${RDEPEND}
	${PYTHON_DEPS}
	virtual/pkgconfig
	test? (
		dev-libs/dbus-glib
		dev-libs/glib
		dev-python/dbus-python
		qt4? ( dev-qt/qttest:4 )
		qt5? ( dev-qt/qttest:5 )
	)
"

DOCS=( AUTHORS ChangeLog HACKING NEWS README )

pkg_setup() {
	python-any-r1_pkg_setup
	MULTIBUILD_VARIANTS=()
	if use qt4; then
		MULTIBUILD_VARIANTS+=(qt4)
	fi
	if use qt5; then
		MULTIBUILD_VARIANTS+=(qt5)
	fi
}

src_configure() {
	myconfigure() {
		local mycmakeargs=(
			$(cmake-utils_use_enable debug DEBUG_OUTPUT)
			$(cmake-utils_use_enable farstream)
			$(cmake-utils_use_enable test TESTS)
			-DENABLE_EXAMPLES=OFF
			-ENABLE_SERVICE_SUPPORT=ON
		)
		if [[ ${MULTIBUILD_VARIANT} = qt4 ]]; then
			mycmakeargs+=(-DDESIRED_QT_VERSION=4)
		fi
		if [[ ${MULTIBUILD_VARIANT} = qt5 ]]; then
			mycmakeargs+=(-DDESIRED_QT_VERSION=5)
		fi
		cmake-utils_src_configure
	}

	multibuild_foreach_variant myconfigure
}

src_compile() {
	multibuild_foreach_variant cmake-utils_src_compile
}

src_install() {
	multibuild_foreach_variant cmake-utils_src_install
}

src_test() {
	mytest() {
		pushd "${BUILD_DIR}" > /dev/null
		Xemake test || die "tests failed"
		popd > /dev/null
	}

	multibuild_foreach_variant mytest
}
