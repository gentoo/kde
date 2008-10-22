# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdebindings
KMMODULE="python/krosspython"
# Required for python/pykde4/cmake/modules/FindPythonLibrary.cmake which is
# used by krosspython
KMEXTRACTONLY="python/pykde4"

inherit kde4svn-meta

DESCRIPTION="Kross scripting framework: Python interpreter"
KEYWORDS=""
IUSE="debug"

DEPEND="dev-lang/python"
RDEPEND="${DEPEND}"
