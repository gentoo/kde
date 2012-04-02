# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kde-workspace"
inherit kde4-meta

DESCRIPTION="Applet for KDE and X clipboard management"
KEYWORDS=""
IUSE="debug prison"

DEPEND="
	$(add_kdebase_dep libkworkspace)
	$(add_kdebase_dep libtaskmanager)
	prison? ( media-libs/prison )
	!aqua? ( x11-libs/libXfixes )
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with prison Prison)
	)

	kde4-meta_src_configure
}
