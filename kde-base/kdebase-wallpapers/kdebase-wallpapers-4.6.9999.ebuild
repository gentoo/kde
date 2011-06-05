# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KMNAME="kde-wallpapers"
KMMODULE="wallpapers"
KDE_SCM="svn"
KDE_REQUIRED="never"
inherit kde4-meta

DESCRIPTION="KDE wallpapers"
KEYWORDS=""
IUSE=""

src_configure() {
	mycmakeargs=( -DWALLPAPER_INSTALL_DIR=${EKDEDIR}/share/wallpapers )

	kde4-base_src_configure
}
