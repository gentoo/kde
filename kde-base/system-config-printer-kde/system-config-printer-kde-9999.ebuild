# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdeadmin"
inherit kde4-meta

DESCRIPTION="KDE port of Red Hat's Gnome system-config-printer"
KEYWORDS=""
IUSE=""

DEPEND="
	app-admin/system-config-printer
	>=dev-python/PyQt4-4.4.4-r1
	dev-python/pycups
	>=kde-base/pykde4-${PV}:${SLOT}
"
RDEPEND="${DEPEND}"
