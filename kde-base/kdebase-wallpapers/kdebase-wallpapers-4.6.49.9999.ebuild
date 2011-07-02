# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KMNAME="kde-wallpapers"
KMMODULE="wallpapers"
KDE_SCM="svn"
inherit kde4-base

DESCRIPTION="KDE wallpapers"
KEYWORDS=""
IUSE=""

src_configure() {
	mycmakeargs=( -DWALLPAPER_INSTALL_DIR="${EPREFIX}/usr/share/wallpapers" )

	kde4-base_src_configure
}
