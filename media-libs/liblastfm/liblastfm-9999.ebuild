# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils multibuild git-r3

DESCRIPTION="Collection of libraries to integrate Last.fm services"
HOMEPAGE="https://github.com/lastfm/liblastfm"
EGIT_REPO_URI=( "git://github.com/lastfm/${PN}" )

LICENSE="GPL-3"
KEYWORDS=""
SLOT="0/0"
IUSE="fingerprint test +qt4 qt5"

REQUIRED_USE="|| ( qt4 qt5 )"

COMMON_DEPEND="
	qt4? (
		dev-qt/qtcore:4
		dev-qt/qtdbus:4
	)
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtdbus:5
		dev-qt/qtnetwork:5
		dev-qt/qtxml:5
	)
	fingerprint? (
		media-libs/libsamplerate
		sci-libs/fftw:3.0
		qt4? ( dev-qt/qtsql:4 )
		qt5? ( dev-qt/qtsql:5 )
	)
"
DEPEND="${COMMON_DEPEND}
	test? (
		qt4? ( dev-qt/qttest:4 )
		qt5? ( dev-qt/qttest:5 )
	)
"
RDEPEND="${COMMON_DEPEND}
	!<media-libs/lastfmlib-0.4.0
"

# 1 of 2 is failing, last checked 2012-06-22 / version 1.0.1
RESTRICT="test"

pkg_setup() {
	MULTIBUILD_VARIANTS=( $(usev qt4) $(usev qt5) )
}

src_configure() {
	myconfigure() {
		# demos not working
		local mycmakeargs=(
			-DBUILD_DEMOS=OFF
			$(cmake-utils_use_build fingerprint)
			$(cmake-utils_use_build test TESTS)
		)
		if [[ ${MULTIBUILD_VARIANT} = qt4 ]]; then
			mycmakeargs+=(-DBUILD_WITH_QT4=ON)
		fi
		if [[ ${MULTIBUILD_VARIANT} = qt5 ]]; then
			mycmakeargs+=(-DBUILD_WITH_OT4=OFF)
		fi
		cmake-utils_src_configure
	}

	multibuild_foreach_variant myconfigure
}

src_compile() {
	multibuild_foreach_variant cmake-utils_src_compile
}

src_test() {
	multibuild_foreach_variant cmake-utils_src_test
}

src_install() {
	multibuild_foreach_variant cmake-utils_src_install
}
