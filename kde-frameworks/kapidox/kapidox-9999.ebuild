# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )
inherit frameworks.kde.org distutils-r1

DESCRIPTION="Framework for building KDE API documentation in a standard format and style"

LICENSE="BSD-2"
KEYWORDS=""
IUSE=""

RDEPEND="
	app-text/doxygen
	$(python_gen_cond_dep '
		dev-python/jinja2[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
	')
	media-gfx/graphviz[python,${PYTHON_SINGLE_USEDEP}]
"
