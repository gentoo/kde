# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdeutils"
inherit kde4-meta

DESCRIPTION="KDE printer system tray utility"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	>=app-admin/system-config-printer-common-1.1.8
	app-misc/hal-cups-utils
	>=kde-base/pykde4-${PV}:${SLOT}[kdeprefix=]
"
RDEPEND="${DEPEND}"
