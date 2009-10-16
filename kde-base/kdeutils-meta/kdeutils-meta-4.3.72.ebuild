# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeutils-meta/kdeutils-meta-4.2.4.ebuild,v 1.2 2009/06/04 23:50:14 alexxy Exp $

EAPI="2"
inherit kde4-functions

DESCRIPTION="kdeutils - merge this to pull in all kdeutils-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="4.4"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="cups floppy kdeprefix lirc"

RDEPEND="
	$(add_kdebase_dep ark)
	$(add_kdebase_dep kcalc)
	$(add_kdebase_dep kcharselect)
	$(add_kdebase_dep kdessh)
	$(add_kdebase_dep kdf)
	$(add_kdebase_dep kgpg)
	$(add_kdebase_dep ktimer)
	$(add_kdebase_dep kwallet)
	$(add_kdebase_dep superkaramba)
	$(add_kdebase_dep sweeper)
	$(add_kdebase_dep okteta)
	cups? ( $(add_kdebase_dep printer-applet) )
	floppy? ( $(add_kdebase_dep kfloppy) )
	lirc? ( $(add_kdebase_dep kdelirc) )
	$(block_other_slots)
"
