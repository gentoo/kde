# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kstars/kstars-4.2.1.ebuild,v 1.2 2009/03/08 14:01:39 scarabeus Exp $
EAPI="2"

KMNAME="kdeedu"
inherit kde4-meta

DESCRIPTION="KDE Desktop Planetarium"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug fits"

DEPEND="
	>=kde-base/libkdeedu-${PV}:${SLOT}[kdeprefix=]
	fits? ( >=sci-libs/cfitsio-0.390 )
"
RDEPEND="${DEPEND}"

# FIXME: Re-add as soon as indilib-0.6 is available
#	indi? ( >=sci-libs/indilib-0.6 )"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with fits CFitsio)"

# FIXME: see above
#		$(cmake-utils_use_with indi INDI)"

	kde4-meta_src_configure
}
