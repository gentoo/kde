# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KMNAME="kde-runtime"
inherit kde4-meta

DESCRIPTION="KDE Password Server"
KEYWORDS=""
IUSE="debug semantic-desktop"

DEPEND="
	semantic-desktop? (
		app-crypt/gpgme
		$(add_kdebase_dep kdepimlibs)
	)
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package semantic-desktop Gpgme)
		$(cmake-utils_use_find_package semantic-desktop QGpgme)
	)

	kde4-base_src_configure
}
