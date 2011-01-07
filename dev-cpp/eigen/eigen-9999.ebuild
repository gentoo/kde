# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit cmake-utils mercurial

DESCRIPTION="Lightweight C++ template library for vector and matrix math, a.k.a. linear algebra"
HOMEPAGE="http://eigen.tuxfamily.org/"
#SRC_URI="http://bitbucket.org/eigen/eigen2/get/${PV}.tar.bz2"
EHG_REPO_URI="https://bitbucket.org/eigen/eigen"

LICENSE="GPL-3"
KEYWORDS=""
SLOT="3"
IUSE="debug doc examples test"

RDEPEND="
	examples? (
		x11-libs/qt-gui:4
		x11-libs/qt-opengl:4
	)
"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
"

S="${WORKDIR}/eigen"

src_configure() {
	# benchmarks (BTL) brings up damn load of external deps including fortran
	# compiler
	# library hangs up complete compilation proccess, test later
	mycmakeargs=(
		-DEIGEN_BUILD_LIB=OFF
		-DEIGEN_BUILD_BTL=OFF
		$(cmake-utils_use examples EIGEN_BUILD_DEMOS)
		$(cmake-utils_use test EIGEN_BUILD_TESTS)
		$(cmake-utils_use test EIGEN_TEST_NO_FORTRAN)
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
	use doc && cmake-utils_src_compile doc
}

src_install() {
	use doc && HTML_DOCS=("${CMAKE_BUILD_DIR}/doc/html/")
	cmake-utils_src_install

	if use examples; then
		cd "${CMAKE_BUILD_DIR}"/demos
		dobin mandelbrot/mandelbrot opengl/quaternion_demo || die "dobin failed"
	fi
}
