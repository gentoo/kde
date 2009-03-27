# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/klipper/klipper-4.2.1.ebuild,v 1.2 2009/03/08 13:46:40 scarabeus Exp $

EAPI="2"

KMNAME="kdebase-workspace"
inherit kde4-meta

DESCRIPTION="Applet for KDE and X clipboard management"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

DEPEND="
	>=kde-base/libkworkspace-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/libtaskmanager-${PV}:${SLOT}[kdeprefix=]
	x11-libs/libXfixes
"
RDEPEND="${DEPEND}"
