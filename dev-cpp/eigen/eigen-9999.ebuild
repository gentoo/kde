# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils mercurial

DESCRIPTION="C++ template library for linear algebra: vectors, matrices, and related algorithms"
HOMEPAGE="http://eigen.tuxfamily.org/"
EHG_REPO_URI="https://bitbucket.org/${PN}/${PN}"

LICENSE="LGPL-2 GPL-3"
KEYWORDS=""
SLOT="3"
IUSE="debug doc"

DEPEND="doc? ( app-doc/doxygen[dot,latex] )"
RDEPEND="!dev-cpp/eigen:0"

src_prepare() {
	sed -i CMakeLists.txt \
		-e "/add_subdirectory(demos/d" \
		-e "/add_subdirectory(blas/d" \
		-e "/add_subdirectory(lapack/d" \
		|| die "sed disable unused bundles failed"
}

src_configure() {
	# benchmarks (BTL) brings up damn load of external deps including fortran
	# compiler
	CMAKE_BUILD_TYPE="release"
	mycmakeargs=(
		-DEIGEN_BUILD_BTL=OFF
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
	if use doc; then
		cmake-utils_src_compile doc
	fi
}

src_test() {
	mycmakeargs=(
		-DEIGEN_BUILD_TESTS=ON
		-DEIGEN_TEST_NO_FORTRAN=ON
		-DEIGEN_TEST_NO_OPENGL=ON
	)
	cmake-utils_src_configure
	cmake-utils_src_compile buildtests
	cmake-utils_src_test
}

src_install() {
	cmake-utils_src_install
	if use doc; then
		cd "${BUILD_DIR}"/doc
		dohtml -r html/*
	fi
}
