# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdeutils"
inherit kde4-meta

DESCRIPTION="KDE printer system tray utility"
KEYWORDS=""
IUSE=""

DEPEND="
	app-admin/system-config-printer
	app-misc/hal-cups-utils
	>=dev-python/PyQt4-4.4.4-r1
	dev-python/pycups
	>=kde-base/pykde4-${PV}:${SLOT}
"
RDEPEND="${DEPEND}"
