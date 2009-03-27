# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libplasmaclock/libplasmaclock-4.2.1.ebuild,v 1.3 2009/03/15 14:40:31 scarabeus Exp $

EAPI="2"

KMNAME="kdebase-workspace"
KMMODULE="libs/plasmaclock"
OPENGL_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="Libraries for KDE Plasma's clocks"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug xinerama"

RDEPEND="
	!kdeprefix? ( !kde-base/plasma-workspace:4.1[-kdeprefix] )
"

KMSAVELIBS="true"
