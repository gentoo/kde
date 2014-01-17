# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MY_P="${P#lib}"
MY_PN="${PN#lib}"

if [[ $PV = *9999* ]]; then
	EGIT_REPO_URI=( "git://anongit.kde.org/attica" )
	KEYWORDS=""
	scm_eclass=git-r3
else
	SRC_URI="mirror://kde/stable/${MY_PN}/${MY_P}.tar.bz2"
	KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux"
fi

inherit cmake-utils ${scm_eclass} multibuild

DESCRIPTION="A library providing access to Open Collaboration Services"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
IUSE="debug +qt4 qt5 test"

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

DOCS=( AUTHORS ChangeLog README )

[[ ${PV} != *9999 ]] && S=${WORKDIR}/${MY_P}

pkg_setup() {
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
	multibuild_foreach_variant cmake-utils_src_test
}
