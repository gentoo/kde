# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )
inherit distutils-r1 pypi

DESCRIPTION="Read and write Advanced Authoring Format (AAF) files."
HOMEPAGE="https://pypi.org/project/pyaaf2/ https://github.com/markreidvfx/pyaaf2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~riscv ~x86"

distutils_enable_tests pytest
