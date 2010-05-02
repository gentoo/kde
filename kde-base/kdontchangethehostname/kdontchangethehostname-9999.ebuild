# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

KMNAME="kdebase-runtime"
inherit kde4-meta

DESCRIPTION="Tool to inform KDE about a change in hostname"
KEYWORDS=""
IUSE="debug"

# moved from kdelibs
add_blocker kdelibs 4.4.68

# this needs actually only 0.3.0 but kdelibs[semantic-desktop] requires 0.3.60, so for minimum mess...
DEPEND=">=dev-libs/shared-desktop-ontologies-0.3.60"
RDEPEND="${DEPEND}"
