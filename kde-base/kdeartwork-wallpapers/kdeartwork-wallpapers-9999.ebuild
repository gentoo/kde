# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

RESTRICT="binchecks strip"

KMMODULE="wallpapers"
KMNAME="kdeartwork"
inherit kde4-meta

DESCRIPTION="Wallpapers from kde"
KEYWORDS=""
IUSE=""

RDEPEND="
	!kdeprefix? ( !<kde-base/kde-wallpapers-${PV}[-kdeprefix] )
	kdeprefix? ( !<kde-base/kde-wallpapers-$PV:${SLOT}[kdeprefix=] )
"
