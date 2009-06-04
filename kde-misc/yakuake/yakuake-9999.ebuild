# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="extragear/utils"
inherit kde4-base

DESCRIPTION="A quake-style terminal emulator based on KDE konsole technology"
HOMEPAGE="http://yakuake.kde.org/"

LICENSE="GPL-2 LGPL-2"
KEYWORDS=""
SLOT="3"
IUSE="debug"

RDEPEND="
	!kdeprefix? ( !kde-misc/yakuake:0 )
	!kde-misc/yakuake:4.1
	>=kde-base/konsole-${KDE_MINIMAL}
"
