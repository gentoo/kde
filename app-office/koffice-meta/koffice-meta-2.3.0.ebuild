# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="KOffice - merge this to pull in all KOffice-derived packages."
HOMEPAGE="http://www.koffice.org/"
LICENSE="GPL-2"

SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE="nls reports"

RDEPEND="
	>=app-office/karbon-${PV}:${SLOT}
	>=app-office/kexi-${PV}:${SLOT}
	>=app-office/koffice-data-${PV}:${SLOT}
	>=app-office/koffice-libs-${PV}:${SLOT}
	>=app-office/kpresenter-${PV}:${SLOT}
	>=app-office/krita-${PV}:${SLOT}
	>=app-office/kspread-${PV}:${SLOT}
	>=app-office/kword-${PV}:${SLOT}
	nls? ( >=app-office/koffice-l10n-${PV}:${SLOT} )
	reports? ( >=app-office/kplato-${PV}:${SLOT} )
	!app-office/kchart
"
