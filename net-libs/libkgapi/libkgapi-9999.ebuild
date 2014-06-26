# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_LINGUAS=""
KDE_MINIMAL="4.12"
inherit kde4-base

DESCRIPTION="Library for accessing Google calendar and contact resources"
HOMEPAGE="https://projects.kde.org/projects/extragear/libs/libkgapi"

LICENSE="GPL-2"
KEYWORDS=""
IUSE="debug"
SLOT=4

DEPEND="
	$(add_kdebase_dep kdepimlibs)
	dev-libs/qjson
"
RDEPEND=${DEPEND}

src_configure() {
	local mycmakeargs=(
		-DKGAPI_DISABLE_DEPRECATED=TRUE
		-DKCAL=OFF
	)
	kde4-base_src_configure
}
