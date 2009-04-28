# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdereview"
inherit kde4-base

DESCRIPTION="New KDE crash handler, gives the user feedback if a program crashed"
KEYWORDS=""
IUSE="debug"

# Temporary blocks for existing drkonqui
RDEPEND="
	!kdeprefix? (
		!kde-base/drkonqi:4.1[-kdeprefix]
		!kde-base/drkonqi:4.2[-kdeprefix]
		!kde-base/drkonqi:4.3[-kdeprefix]
	)
	kdeprefix? ( !kde-base/drkonqi-${SLOT} )
	sys-devel/gdb
"
