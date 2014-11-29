# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KMNAME="kdeartwork"
KMMODULE="IconThemes"
KDE_SCM="svn"
inherit kde4-meta

DESCRIPTION="Icon themes for kde"
KEYWORDS=""
IUSE=""

# Provides nuvola icon theme
RDEPEND="
	!x11-themes/nuvola
"
