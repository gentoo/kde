# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

if [[ ${PV} == *9999 ]]; then
	eclass="kde4-base"
else
	eclass="kde4-meta"
	KMNAME="kdegames"
fi
KDE_HANDBOOK="optional"
PYTHON_DEPEND="2:2.6"
inherit ${eclass} python

DESCRIPTION="The classical Mah Jongg for four players"
KEYWORDS="~amd64 ~arm ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	dev-db/sqlite:3
	$(add_kdebase_dep libkdegames)
	$(add_kdebase_dep pykde4)
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep libkmahjongg)
	>=dev-python/twisted-8.2.0
"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
	${eclass}_pkg_setup
}

src_prepare() {
	if [[ ${PV} == *9999 ]]; then
		python_convert_shebangs -r 2 src
	else
		python_convert_shebangs -r 2 kajongg/src
	fi
	${eclass}_src_prepare
}
