# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kwrited/kwrited-4.2.1.ebuild,v 1.3 2009/03/15 14:37:54 scarabeus Exp $

EAPI="2"
KMNAME="kdebase-workspace"
inherit kde4-meta

DESCRIPTION="KDE daemon listening for wall and write messages."
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

DEPEND="
	>=sys-libs/libutempter-1.1.5
"
RDEPEND="${DEPEND}
	!kdeprefix? ( !kde-base/konsole:4.1[-kdeprefix] )
"
