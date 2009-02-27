# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase-desktoptheme/kdebase-desktoptheme-4.2.0.ebuild,v 1.3 2009/02/06 00:03:03 ranger Exp $

EAPI="2"

KMNAME="kdebase-runtime"
KMMODULE="desktoptheme"
inherit kde4-meta

DESCRIPTION="oxygen desktoptheme from kdebase"
IUSE=""
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

RDEPEND="${DEPEND}
	!kdeprefix? ( !kde-base/plasma-workspace:4.1[-kdeprefix] )
	!<kde-base/plasma-workspace-${PV}:${SLOT}[kdeprefix=]
	"
