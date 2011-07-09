# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

if [[ $PV == *9999* ]]; then
	KMNAME="kde-wallpapers"
	KMMODULE="wallpapers"
	KDE_SCM="svn"
	kde_eclass=kde4-base
else
	KMNAME="kdebase-workspace"
	KMMODULE="wallpapers"
	kde_eclass=kde4-meta
fi

inherit ${kde_eclass}

DESCRIPTION="KDE wallpapers"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

src_configure() {
	mycmakeargs=( -DWALLPAPER_INSTALL_DIR="${EPREFIX}/usr/share/wallpapers" )

	${kde_eclass}_src_configure
}
