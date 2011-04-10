# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

KDE_HANDBOOK="optional"
KMNAME="kdegraphics"
inherit kde4-meta

DESCRIPTION="KDE Screenshot Utility"
KEYWORDS=""
IUSE="debug kipi"

DEPEND="
	kipi? ( $(add_kdebase_dep libkipi) )
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-4.6.2-kipi.patch" )

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with kipi)
	)

	kde4-meta_src_configure
}
