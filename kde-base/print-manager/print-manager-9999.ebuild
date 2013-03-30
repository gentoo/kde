# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

DESCRIPTION="Manage print jobs and printers in KDE"
KEYWORDS=""
IUSE="debug"

DEPEND="
	net-print/cups[dbus]
"
RDEPEND="${DEPEND}
	!kde-misc/print-manager
"

add_blocker printer-applet
add_blocker system-config-printer-kde
