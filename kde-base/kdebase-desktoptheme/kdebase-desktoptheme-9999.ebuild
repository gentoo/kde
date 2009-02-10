# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebase-runtime"
KMMODULE="desktoptheme"
inherit kde4-meta

DESCRIPTION="oxygen desktoptheme from kdebase"
IUSE=""
KEYWORDS=""

RDEPEND="
	!kdeprefix? ( !<kde-base/plasma-workspace-${PV} )
	kdeprefix? ( !<kde-base/plasma-workspace-${PV}:${SLOT} )
"
