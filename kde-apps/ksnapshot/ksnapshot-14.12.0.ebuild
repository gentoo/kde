# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="KDE Screenshot Utility"
HOMEPAGE="http://www.kde.org/applications/graphics/ksnapshot/"
KEYWORDS=" ~amd64 ~x86"
IUSE="debug kipi"

DEPEND="
	x11-libs/libXfixes
	!aqua? (
		x11-libs/libX11
		x11-libs/libXext
	)
	kipi? ( $(add_kdeapps_dep libkipi) )
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with kipi)
	)

	kde4-base_src_configure
}
