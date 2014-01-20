# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

FRAMEWORKS_AUTODEPS="false"
FRAMEWORKS_TEST="false"
inherit kde-frameworks multibuild

DESCRIPTION="Framework providing access to Open Collaboration Services"
LICENSE="LGPL-2.1+"
KEYWORDS=""
IUSE="debug +qt4 qt5 test"

REQUIRED_USE="|| ( qt4 qt5 )"

RDEPEND="
	qt4? ( dev-qt/qtcore:4 )
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtnetwork:5
	)
	!<dev-libs/libattica-9999
"
DEPEND="${RDEPEND}
	qt5? (
		dev-libs/extra-cmake-modules
		dev-qt/qtconcurrent:5
	)
	test? (
		qt4? (
			dev-qt/qtgui:4
			dev-qt/qttest:4
		)
		qt5? (
			dev-qt/qttest:5
			dev-qt/qtwidgets:5
		)
	)
"

pkg_setup() {
	kde-frameworks_pkg_setup

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
		)
		if [[ ${MULTIBUILD_VARIANT} = qt4 ]]; then
			mycmakeargs+="-DCMAKE_DISABLE_FIND_PACKAGE_Qt5Core=ON"
		fi
		if [[ ${MULTIBUILD_VARIANT} = qt5 ]]; then
			mycmakeargs+="-DCMAKE_DISABLE_FIND_PACKAGE_Qt5Core=OFF"
		fi
		kde-frameworks_src_configure
	}

	multibuild_foreach_variant myconfigure
}

src_compile() {
	multibuild_foreach_variant kde-frameworks_src_compile
}

src_install() {
	multibuild_foreach_variant kde-frameworks_src_install
}

src_test() {
	multibuild_foreach_variant kde-frameworks_src_test
}
