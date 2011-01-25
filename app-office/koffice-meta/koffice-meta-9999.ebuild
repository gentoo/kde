# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#
# Please note that koffice is currently bumped "forward" and that this live
# ebuild is more or less unmaintained.
#


EAPI="3"

DESCRIPTION="KOffice - merge this to pull in all KOffice-derived packages"
HOMEPAGE="http://www.koffice.org/"
LICENSE="GPL-2"

SLOT="2"
KEYWORDS=""
IUSE="reports"

RDEPEND="
	>=app-office/karbon-${PV}:${SLOT}
	>=app-office/kexi-${PV}:${SLOT}
	>=app-office/koffice-data-${PV}:${SLOT}
	>=app-office/koffice-libs-${PV}:${SLOT}[reports?]
	>=app-office/kpresenter-${PV}:${SLOT}
	>=app-office/krita-${PV}:${SLOT}
	>=app-office/kspread-${PV}:${SLOT}
	>=app-office/kword-${PV}:${SLOT}
	reports? ( >=app-office/kplato-${PV}:${SLOT} )
	!app-office/kchart
"
