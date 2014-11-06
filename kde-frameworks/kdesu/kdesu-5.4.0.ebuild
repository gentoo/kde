# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-frameworks/kdesu/kdesu-5.3.0.ebuild,v 1.1 2014/10/15 13:29:45 kensington Exp $

EAPI=5

KDE_TEST="false"
inherit kde5

DESCRIPTION="Framework to handle super user actions"
LICENSE="LGPL-2"
KEYWORDS=" ~amd64"
IUSE="X"

RDEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kpty)
	$(add_frameworks_dep kservice)
"
DEPEND="${RDEPEND}
	X? (
		x11-libs/libX11
		x11-proto/xproto
	)
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package X X11)
	)

	kde5_src_configure
}
