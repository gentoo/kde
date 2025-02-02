# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
inherit distutils-r1 pypi

DESCRIPTION="Parser for CMakeLists.txt files"
HOMEPAGE="
	https://github.com/wjwwood/parse_cmake
	https://pypi.org/project/parse_cmake/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

PATCHES=(
	"${FILESDIR}/${P}-python3-fix.patch"
	"${FILESDIR}/${P}-dont-install-tests.patch"
)

distutils_enable_tests unittest

src_prepare() {
	distutils-r1_src_prepare
	sed -i setup.py -e "s/'pyPEG2'//" || die
}
