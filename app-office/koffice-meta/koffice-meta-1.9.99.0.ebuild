# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="KOffice - merge this to pull in all KOffice-derived packages."
HOMEPAGE="http://www.koffice.org/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

RDEPEND="
	>=app-office/karbon-${PV}
	>=app-office/kchart-${PV}
	>=app-office/koffice-data-${PV}
	>=app-office/koffice-libs-${PV}
	>=app-office/kplato-${PV}
	>=app-office/kpresenter-${PV}
	>=app-office/krita-${PV}
	>=app-office/kspread-${PV}
	>=app-office/kword-${PV}
	nls? ( >=app-office/koffice-l10n-${PV} )
"
