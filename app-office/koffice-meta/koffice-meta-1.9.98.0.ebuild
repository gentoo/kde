# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/koffice-meta/koffice-meta-1.6.3.ebuild,v 1.8 2007/07/26 17:43:01 corsair Exp $

EAPI="2"

DESCRIPTION="KOffice - merge this to pull in all KOffice-derived packages."
HOMEPAGE="http://www.koffice.org/"
LICENSE="GPL-2"

SLOT="4.1"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=app-office/karbon-${PV}:${SLOT}
        >=app-office/kchart-${PV}:${SLOT}
        >=app-office/kexi-${PV}:${SLOT}
        >=app-office/kformula-${PV}:${SLOT}
        >=app-office/kivio-${PV}:${SLOT}
        >=app-office/koffice-data-${PV}:${SLOT}
        >=app-office/koffice-libs-${PV}:${SLOT}
        >=app-office/koshell-${PV}:${SLOT}
        >=app-office/kplato-${PV}:${SLOT}
        >=app-office/kpresenter-${PV}:${SLOT}
        >=app-office/krita-${PV}:${SLOT}
        >=app-office/kspread-${PV}:${SLOT}
        >=app-office/kugar-${PV}:${SLOT}
        >=app-office/kword-${PV}:${SLOT}"

