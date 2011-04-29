# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

PYTHON_DEPEND="python? 2:2.5"

inherit python cmake-utils

DESCRIPTION="Library for performing fast approximate nearest neighbor searches in high dimensional spaces"
HOMEPAGE="http://www.cs.ubc.ca/~mariusm/index.php/FLANN/FLANN"
SRC_URI="http://people.cs.ubc.ca/~mariusm/uploads/FLANN/${P}-src.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="python test"

RDEPEND="sci-libs/hdf5[mpi,threads]
	python? ( dev-python/numpy )"
DEPEND="${DEPEND}
	test? ( dev-util/gtest )"

S=${WORKDIR}/${P}-src

src_prepare() {
	sed -i -e "s:share/doc/flann:share/doc/${PF}:" doc/CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=(
		"-DBUILD_C_BINDINGS=ON"
		"-DBUILD_MATLAB_BINDINGS=OFF"
		$(cmake-utils_use_build python PYTHON_BINDINGS)
	)
	cmake-utils_src_configure
}

src_test() {
	cd "${CMAKE_BUILD_DIR}"
	make test || die
}
