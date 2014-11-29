# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_DEBUG="false"
KDE_DOXYGEN="false"
KDE_TEST="false"
PYTHON_COMPAT=( python{2_7,3_3,3_4} )
inherit kde5 distutils-r1

DESCRIPTION="Framework for building KDE API documentation in a standard format and style"
LICENSE="BSD-2"
KEYWORDS=""
IUSE=""

RDEPEND="
	app-doc/doxygen
	dev-python/pystache[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	media-gfx/graphviz[python]
"
# graphviz is currently python-single-r1 so we can't enforce a USE dep yet
# and things will break if you try to generate a dependency diagram with a
# different python version
