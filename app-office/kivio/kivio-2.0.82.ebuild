# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="koffice"
inherit kde4-meta

DESCRIPTION="KOffice flowchart application."
KEYWORDS="~amd64 ~x86"
IUSE="debug python"

DEPEND="
	python? ( >=kde-base/pykde4-${KDE_MINIMAL} )
"
RDEPEND="${DEPEND}"

KMEXTRA="
	filters/${KMMODULE}
"
KMEXTRACTONLY="
	filters/
	libs/
	plugins/
"

KMLOADLIBS="koffice-libs"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with python PythonLibs)"

	kde4-meta_src_configure
}
