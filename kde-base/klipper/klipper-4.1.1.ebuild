# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/klipper/klipper-4.0.5.ebuild,v 1.1 2008/06/05 21:56:56 keytoaster Exp $

EAPI="1"

KMNAME=kdebase-workspace
inherit kde4-meta

DESCRIPTION="Applet for KDE and X clipboard management"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

DEPEND=">=kde-base/libkworkspace-${PV}:${SLOT}
	>=kde-base/libtaskmanager-${PV}:${SLOT}
	x11-libs/libXfixes"
RDEPEND="${DEPEND}"
