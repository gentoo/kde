# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

KDE_SCM="git"
KMNAME="kde-runtime"
inherit kde4-meta

DESCRIPTION="Tool to inform KDE about a change in hostname"
KEYWORDS=""
IUSE="debug"

RDEPEND="
	x11-apps/xauth
"

# moved from kdelibs
add_blocker kdelibs 4.4.68
