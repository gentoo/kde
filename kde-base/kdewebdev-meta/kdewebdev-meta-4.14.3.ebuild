# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdewebdev-meta/kdewebdev-meta-4.14.3.ebuild,v 1.3 2015/02/14 14:35:00 ago Exp $

EAPI=5
inherit kde4-meta-pkg

DESCRIPTION="KDE WebDev - merge this to pull in all kdewebdev-derived packages"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	$(add_kdebase_dep kfilereplace)
	$(add_kdebase_dep kimagemapeditor)
	$(add_kdebase_dep klinkstatus)
	$(add_kdebase_dep kommander)
"
