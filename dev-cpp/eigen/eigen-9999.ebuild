# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit cmake-utils mercurial

DESCRIPTION="Lightweight C++ template library for vector and matrix math, a.k.a. linear algebra"
HOMEPAGE="http://eigen.tuxfamily.org/"
#SRC_URI="http://bitbucket.org/eigen/eigen2/get/${PV}.tar.bz2"
EHG_REPO_URI="https://bitbucket.org/eigen/eigen"

LICENSE="GPL-3"
KEYWORDS=""
SLOT="3"
IUSE="debug doc examples"

DEPEND="
	examples? (
		x11-libs/qt-gui:4
		x11-libs/qt-opengl:4
	)
	doc? ( app-doc/doxygen )
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/eigen"

src_configure() {
	# benchmarks (BTL) brings up damn load of external deps including fortran
	# compiler
	# library hangs up complete compilation proccess, test later
	mycmakeargs=(
		-DEIGEN_BUILD_LIB=OFF
		-DEIGEN_BUILD_BTL=OFF
		$(cmake-utils_use examples EIGEN_BUILD_DEMOS)
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
	if use doc; then
		cd "${CMAKE_BUILD_DIR}"
		emake doc || die "building documentation failed"
	fi
}

src_test() {
	mycmakeargs+=(
		-DEIGEN_BUILD_TESTS=ON
		-DEIGEN_TEST_NO_FORTRAN=ON
	)
	cmake-utils_src_configure
	cmake-utils_src_compile
	cmake-utils_src_test
}

src_install() {
	cmake-utils_src_install
	if use doc; then
		cd "${CMAKE_BUILD_DIR}"/doc
		dohtml -r html/* || die "dohtml failed"
	fi
	if use examples; then
		cd "${CMAKE_BUILD_DIR}"/demos
		dobin mandelbrot/mandelbrot opengl/quaternion_demo || die "dobin failed"
	fi
}
