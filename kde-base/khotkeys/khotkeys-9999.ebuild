# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdebase-workspace
inherit kde4svn-meta

DESCRIPTION="KDE: hotkey daemon"
KEYWORDS=""
IUSE="debug"

DEPEND=">=kde-base/libkworkspace-${PV}:${SLOT}
	x11-libs/libXtst"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="libs/kworkspace/"
src_compile() {
        MAKEOPTS="${MAKEOPTS} -j1" kde4overlay-meta_src_compile
}

