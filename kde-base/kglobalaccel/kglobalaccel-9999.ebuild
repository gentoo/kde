# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebase-runtime"
inherit kde4-meta

DESCRIPTION="KDE's Global Shortcut Daemon"
KEYWORDS=""
IUSE="debug"

# Module renamed upstream
RDEPEND="
	!kdeprefix? ( !kde-base/kdedglobalaccel[-kdeprefix] )
	kdeprefix? ( !kde-base/kdedglobalaccel:${SLOT} )
"
