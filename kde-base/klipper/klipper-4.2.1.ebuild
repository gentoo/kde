# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebase-workspace"
inherit kde4-meta

DESCRIPTION="Applet for KDE and X clipboard management"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug htmlhandbook"

DEPEND="
	>=kde-base/libkworkspace-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/libtaskmanager-${PV}:${SLOT}[kdeprefix=]
	x11-libs/libXfixes
"
RDEPEND="${DEPEND}"
