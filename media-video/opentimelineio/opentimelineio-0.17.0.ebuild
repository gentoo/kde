# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
inherit cmake distutils-r1 pypi

DESCRIPTION="Editorial interchange format and API (for use with Kdenlive)."
HOMEPAGE="https://pypi.org/project/OpenTimelineIO/ https://github.com/AcademySoftwareFoundation/OpenTimelineIO"
SRC_URI="$(pypi_sdist_url OpenTimelineIO)"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~riscv ~x86"
IUSE="tools"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="dev-python/pyside[${PYTHON_USEDEP}]
	dev-libs/imath
	dev-python/pyaaf2"
DEPEND="${RDEPEND}"

python_prepare_all() {
	sed -re '/.*: OTIO_build_ext,/d' -i setup.py
	cmake_src_prepare
	distutils-r1_python_prepare_all
}

python_configure() {
	local mycmakeargs=(
		-DOTIO_AUTOMATIC_SUBMODULES=OFF
		-DOTIO_DEPENDENCIES_INSTALL=OFF
		-DOTIO_FIND_IMATH=ON
		-DOTIO_INSTALL_COMMANDLINE_TOOLS="$(usex tools)"
		-DOTIO_INSTALL_CONTRIB=OFF
		-DOTIO_INSTALL_PYTHON_MODULES=OFF
		-DOTIO_PYTHON_INSTALL=ON
		-DOTIO_PYTHON_INSTALL_DIR="$(python_get_sitedir)"
		-DOTIO_SHARED_LIBS=OFF
		-DPython_EXECUTABLE="${PYTHON}"
	)
	cmake_src_configure
}

python_compile() {
	cmake_src_compile
	distutils-r1_python_compile
}

python_install() {
	cmake_src_install
	distutils-r1_python_install
}

distutils_enable_tests unittest
