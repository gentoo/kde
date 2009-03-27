# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcalc/kcalc-4.2.1.ebuild,v 1.2 2009/03/08 13:24:26 scarabeus Exp $

EAPI="2"

KMNAME="kdeutils"
CPPUNIT_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="KDE calculator"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

DEPEND="
	dev-libs/gmp
"
RDEPEND="${DEPEND}"

src_test() {
	pushd "${WORKDIR}"/${PN}_build/kcalc/knumber/tests > /dev/null
	emake knumbertest && \
		./knumbertest.shell || die "Tests failed."
	popd > /dev/null
}
