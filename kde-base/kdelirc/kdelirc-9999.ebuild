# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdeutils"
inherit kde4-meta

DESCRIPTION="KDE frontend for the Linux Infrared Remote Control system"
KEYWORDS=""
IUSE="debug +handbook"

DEPEND="
	>=kde-base/libknotificationitem-${PV}:${SLOT}[kdeprefix=]
"

RDEPEND="${DEPEND}
	!kde-misc/kdelirc
	app-misc/lirc
"
