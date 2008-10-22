# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"
SLOT="kde-svn"
KMNAME=koffice
inherit kde4svn-meta

DESCRIPTION="KOffice flowchart and diagram tool."
KEYWORDS=""
# There is a python switch in the cmake files. But nothing in kivio seems to
# actually use it. Maybe in the future that'll change..
#IUSE="python"
IUSE=""

#DEPEND="python? ( virtual/python )"
DEPEND=">=app-office/koffice-libs-${PV}:${SLOT}
	>=app-office/koffice-data-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

KMEXTRA="filters/kivio/
	doc/koffice/"
KMEXTRACTONLY="libs/"

src_compile() {
	#epatch "${FILESDIR}"/${P}-link_lib.patch

	#mycmakeargs="${mycmakeargs}
		#$(cmake-utils_use_with python PythonLibs)"

	kde4overlay-meta_src_compile
}
