# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="KPilot is software for syncing PalmOS based handhelds."
KEYWORDS="~amd64 ~x86"
IUSE="avantgo debug htmlhandbook pilot-link"

DEPEND="
	app-crypt/qca:2
	>=kde-base/libkdepim-${PV}:${SLOT}
	avantgo? ( >=dev-libs/libmal-0.40 )
	pilot-link? ( >=app-pda/pilot-link-0.12 )
"
RDEPEND="${DEPEND}"
