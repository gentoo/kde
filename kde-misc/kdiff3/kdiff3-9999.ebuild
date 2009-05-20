# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="extragear/utils"
inherit kde4-base

DESCRIPTION="KDE-based frontend to diff3"
HOMEPAGE="http://kdiff3.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="1"
IUSE="debug konqueror"

DEPEND="
	konqueror? ( >=kde-base/libkonq-${KDE_MINIMAL} )
"
RDEPEND="${DEPEND}
	sys-apps/diffutils
	konqueror? ( >=kde-base/konqueror-${KDE_MINIMAL} )
"

PATCHES=( "${FILESDIR}/${PN}-desktop-menu-fix.patch" )

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with konqueror LibKonq)"

	kde4-base_src_configure
}
