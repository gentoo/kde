# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebase-runtime"
KMMODULE="menu"
inherit kde4-meta

DESCRIPTION="KDE menu icons"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE=""

RDEPEND="
	!kdeprefix? ( !kde-base/kde-menu-icons[-kdeprefix] )
	kdeprefix? ( !kde-base/kde-menu-icons:${SLOT} )
"
