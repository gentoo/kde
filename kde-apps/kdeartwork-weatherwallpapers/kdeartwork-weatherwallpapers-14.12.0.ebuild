# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KMNAME="kdeartwork"
KMMODULE="WeatherWallpapers"
KDE_SCM="svn"
inherit kde4-meta

DESCRIPTION="Weather aware wallpapers. Changes with weather outside"
KEYWORDS=" ~amd64 ~x86"
IUSE=""

RDEPEND="
	$(add_kdeapps_dep kdeartwork-wallpapers)
"
