# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit fdo-mime kde-frameworks

DESCRIPTION="Solutions for common problems like caching, randomisation etc."
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE="fam"

RDEPEND="
	dev-qt/qtcore:5[icu]
	fam? ( virtual/fam )
"
DEPEND="${RDEPEND}
	x11-misc/shared-mime-info
"

PATCHES=( "${FILESDIR}/${PN}-mimetypes.patch" )

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package fam FAM)
	)

	kde-frameworks_src_configure
}

pkg_postinst() {
	kde-frameworks_pkg_postinst
	fdo-mime_mime_database_update
}

pkg_postrm() {
	kde-frameworks_pkg_postinst
	fdo-mime_mime_database_update
}
