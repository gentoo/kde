# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

KDE_SCM="git"
if [[ ${PV} == *9999 ]]; then
	KMNAME="kross-interpreters"
	KMMODULE="python"
	kde_eclass="kde4-base"
else
	KMNAME="kdebindings"
	kde_eclass="kde4-meta"
fi
PYTHON_DEPEND="2"
inherit python ${kde_eclass}

DESCRIPTION="Kross scripting framework: Python interpreter"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

pkg_setup() {
	python_set_active_version 2
	${kde_eclass}-meta_pkg_setup
}
