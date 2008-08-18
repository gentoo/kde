# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdetoys
inherit kde4-meta

DESCRIPTION="KDE weather status display"
KEYWORDS="~amd64"
IUSE="debug htmlhandbook"

DEPEND=">=kde-base/libplasma-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

# Tests segfault (4.1.0)
RESTRICT="test"

src_compile() {
	mycmakeargs="${mycmakeargs}
		-DWITH_Plasma=ON"

	kde4-base_src_compile
}

src_test() {
	pushd "${WORKDIR}"/${PN}_build/${PN}/tests > /dev/null
	# The tests seem to fail if there's no station database defined
	# and seem to using wrong var replacement
	emake metar_parser stationdatabase_test sun_test || \
		die "Failed to build tests."
	for t in *.shell; do
		./"$t" || die "Test '$t' failed."
	done
	popd > /dev/null
}
