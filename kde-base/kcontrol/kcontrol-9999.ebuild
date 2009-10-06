# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebase-runtime"
inherit kde4-meta

DESCRIPTION="The KDE Control Center"
KEYWORDS=""
IUSE="debug +handbook"

RDEPEND="
	>=kde-base/kdnssd-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/khotkeys-${PV}:${SLOT}[kdeprefix=]
"

add_blocker ksmserver 4.1.50
add_blocker systemsettings '<4.2.91'
