# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

KDE_SCM="git"
KMNAME="kross-interpreters"
KMMODULE="python"
PYTHON_DEPEND="2"
inherit python kde4-meta

DESCRIPTION="Kross scripting framework: Python interpreter"
KEYWORDS=""
IUSE="debug"

pkg_setup() {
	python_set_active_version 2
	kde4-meta_pkg_setup
}
