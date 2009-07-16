# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdeadmin"
inherit kde4-meta python

DESCRIPTION="KDE port of Red Hat's Gnome system-config-printer"
KEYWORDS=""
IUSE=""

DEPEND="
	>=app-admin/system-config-printer-common-1.1.8
	>=dev-python/pycups-1.9.46
	>=kde-base/pykde4-${PV}:${SLOT}[kdeprefix=]
"
RDEPEND="${DEPEND}
	net-print/cups[dbus]
"
