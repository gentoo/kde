# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

FRAMEWORKS_TYPE="tier1"
inherit kde-frameworks

DESCRIPTION="Solutions for common problems like caching, randomisation etc."
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE="fam"

DEPEND="
	dev-qt/qtcore:5[icu]
	fam? ( virtual/fam )
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package fam FAM)
	)

	kde-frameworks_src_configure
}

src_install() {
	kde-frameworks_src_install

	# avoid collision with kdelibs:4
	mv "${D}"/usr/share/mime/packages/{kde,kde5}.xml || die
}
