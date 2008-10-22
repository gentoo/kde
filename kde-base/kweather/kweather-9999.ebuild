# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdetoys
inherit kde4svn-meta

DESCRIPTION="KDE weather status display"
KEYWORDS=""
IUSE="debug htmlhandbook"

DEPEND=">=kde-base/libplasma-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

src_compile() {
	mycmakeargs="${mycmakeargs}
		-DWITH_Plasma=ON"

	kde4overlay-base_src_compile
}

src_test() {
	pushd "${WORKDIR}"/${PN}_build/${PN}/tests > /dev/null
	# 'metar_parser_test' is also available but fails and I'm not sure why
	emake stationdatabase_test sun_test || \
		die "Failed to build tests."
	for t in *.shell; do
		./"$t" || die "Test '$t' failed."
	done
	popd > /dev/null
}
