# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebase-workspace"
KMMODULE="wallpapers"
inherit kde4-meta

DESCRIPTION="KDE wallpapers"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE=""

RDEPEND="
	!kdeprefix? ( !kde-base/kde-wallpapers[-kdeprefix] )
	kdeprefix? ( !kde-base/kde-wallpapers:${SLOT} )
"
