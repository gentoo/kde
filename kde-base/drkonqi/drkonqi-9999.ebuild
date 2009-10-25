# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebase-runtime"
inherit kde4-meta

DESCRIPTION="KDE crash handler, gives the user feedback if a program crashed"
KEYWORDS=""
IUSE="debug"

add_blocker drkonqi2

pkg_postinst() {
	kde4-meta_pkg_postinst
	elog "For more usability consider installing folowing packages:"
	elog "    sys-devel/gdb - Easier debugging support"
}
