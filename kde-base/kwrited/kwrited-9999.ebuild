# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
KMNAME="kdebase-workspace"
inherit kde4-meta

DESCRIPTION="KDE daemon listening for wall and write messages."
KEYWORDS=""
IUSE="debug"

DEPEND="
	>=sys-libs/libutempter-1.1.5
"
RDEPEND="${DEPEND}
	!kdeprefix? ( !kde-base/konsole:4.1[-kdeprefix] )
"
