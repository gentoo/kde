# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kweather/kweather-4.1.3.ebuild,v 1.2 2008/11/16 08:13:52 vapier Exp $

EAPI="2"

KMNAME=kdetoys
inherit kde4-meta

DESCRIPTION="KDE weather status display"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug htmlhandbook"

DEPEND=">=kde-base/libplasma-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

# Tests segfault (4.1.0)
RESTRICT="test"

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DWITH_Plasma=ON"

	kde4-base_src_configure
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
