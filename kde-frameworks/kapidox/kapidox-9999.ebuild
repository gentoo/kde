# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

FRAMEWORKS_DEBUG="false"
FRAMEWORKS_DOXYGEN="false"
FRAMEWORKS_TEST="false"
PYTHON_COMPAT=( python{2_7,3_2,3_3} )
inherit kde-frameworks distutils-r1

DESCRIPTION="Framework for building KDE API documentation in a standard format and style"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS=""
IUSE=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	app-doc/doxygen
	dev-python/pystache[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	${PYTHON_DEPS}
"
