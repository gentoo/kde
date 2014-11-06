# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-frameworks/kapidox/kapidox-5.3.0.ebuild,v 1.1 2014/10/15 13:29:45 kensington Exp $

EAPI=5

KDE_DEBUG="false"
KDE_DOXYGEN="false"
KDE_TEST="false"
PYTHON_COMPAT=( python{2_7,3_3} )
inherit kde5 distutils-r1

DESCRIPTION="Framework for building KDE API documentation in a standard format and style"
LICENSE="BSD-2"
KEYWORDS=" ~amd64"
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
