# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kgamma/kgamma-4.2.1.ebuild,v 1.1 2009/03/04 21:25:19 alexxy Exp $

EAPI="2"

KMNAME="kdegraphics"
inherit kde4-meta

DESCRIPTION="KDE screen gamma values kcontrol module"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

RDEPEND="
	x11-libs/libXxf86vm
"
DEPEND="${RDEPEND}
	x11-proto/xf86vidmodeproto
"
