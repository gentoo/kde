# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

RESTRICT="binchecks strip"

KMMODULE="wallpapers"
KMNAME="kdeartwork"
KDE_SCM="svn"
inherit kde4-meta

DESCRIPTION="Wallpapers from kde"
KEYWORDS=""
IUSE=""

KMEXTRA="
	HighResolutionWallpapers/
"
