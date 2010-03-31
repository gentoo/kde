# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="koffice"
KMMODULE="${PN}"
inherit kde4-meta

DESCRIPTION="KPlato is a project management application."

KEYWORDS=""
IUSE=""

DEPEND="~app-office/kchart-${PV}:${SLOT}[reports]"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="libs/"
KMEXTRA="
	filters/${KMMODULE}/
	kdgantt/
"
KMLOADLIBS="koffice-libs"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with python PythonLibs)
		-DBUILD_kplato=ON
	)

	kde4-meta_src_configure
}
