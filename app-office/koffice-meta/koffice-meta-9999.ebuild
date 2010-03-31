# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="KOffice - merge this to pull in all KOffice-derived packages."
HOMEPAGE="http://www.koffice.org/"
LICENSE="GPL-2"

SLOT="2"
KEYWORDS=""
IUSE="nls reports"

RDEPEND="
	>=app-office/karbon-${PV}:${SLOT}
	>=app-office/kchart-${PV}:${SLOT}[reports?]
	>=app-office/kexi-${PV}:${SLOT}
	>=app-office/kivio-${PV}:${SLOT}
	>=app-office/koffice-data-${PV}:${SLOT}
	>=app-office/koffice-libs-${PV}:${SLOT}
	>=app-office/kpresenter-${PV}:${SLOT}
	>=app-office/krita-${PV}:${SLOT}
	>=app-office/kspread-${PV}:${SLOT}
	>=app-office/kword-${PV}:${SLOT}
	reports? ( >=app-office/kplato-${PV}:${SLOT} )
"
