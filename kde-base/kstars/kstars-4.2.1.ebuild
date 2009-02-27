# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kstars/kstars-4.2.0.ebuild,v 1.2 2009/02/01 07:59:25 jmbsvicetto Exp $
EAPI="2"

KMNAME="kdeedu"
inherit kde4-meta

DESCRIPTION="KDE Desktop Planetarium"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug fits htmlhandbook"

DEPEND=">=kde-base/libkdeedu-${PV}:${SLOT}
	fits? ( >=sci-libs/cfitsio-0.390 )"

# FIXME: Re-add as soon as indilib-0.6 is available
#	indi? ( >=sci-libs/indilib-0.6 )"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with fits CFitsio)"

# FIXME: see above
#		$(cmake-utils_use_with indi INDI)"

	kde4-meta_src_configure
}
