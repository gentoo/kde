# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdereview"

inherit kde4-base

DESCRIPTION="New KDE crash handler, gives the user feedback if a program crashed"
IUSE="debug"
KEYWORDS=""

DEPEND="
kdeprefix? (
	!>=kde-base/drkonqi-${PV}:${SLOT}
)
!kdeprefix? (
	!kde-base/drkonqi[kdeprefix=]
)
"

RDEPEND="${DEPEND}
	sys-devel/gdb
"
