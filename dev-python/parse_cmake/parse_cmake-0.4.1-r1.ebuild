# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
inherit distutils-r1

DESCRIPTION="Parser for CMakeLists.txt files"
HOMEPAGE="https://pypi.org/project/parse_cmake/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

PATCHES=( "${FILESDIR}/${P}-python3-fix.patch" )

src_prepare() {
	distutils-r1_src_prepare
	sed -i setup.py -e "s/'pyPEG2'//" || die
	mv tests tests-hidden || die
}
