# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebase-workspace"
inherit kde4-meta

DESCRIPTION="Applet for KDE and X clipboard management"
KEYWORDS=""
IUSE="debug +handbook"

SRC_URI="${SRC_URI}
	http://dev.gentooexperimental.org/~scarabeus/${SLOT}-${PN}_empty_actions.patch.bz2
"

DEPEND="
	$(add_kdebase_dep libkworkspace)
	$(add_kdebase_dep libtaskmanager)
	x11-libs/libXfixes
"
RDEPEND="${DEPEND}"

src_unpack() {
	kde4-meta_src_unpack
	unpack "${SLOT}-${PN}_empty_actions.patch.bz2"
}

src_prepare() {
	kde4-meta_src_prepare
	epatch "${WORKDIR}/${SLOT}-${PN}_empty_actions.patch"
}
