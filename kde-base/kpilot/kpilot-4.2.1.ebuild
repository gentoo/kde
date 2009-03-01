# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="KPilot is software for syncing PalmOS based handhelds."
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 "
IUSE="avantgo debug htmlhandbook"

DEPEND="
	app-crypt/qca:2
	>=app-pda/pilot-link-0.12
	>=kde-base/libkdepim-${PV}:${SLOT}[kdeprefix=]
	avantgo? ( >=dev-libs/libmal-0.40 )
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs="$(cmake-utils_use_with avantgo Mal)"

	kde4-meta_src_configure
}
