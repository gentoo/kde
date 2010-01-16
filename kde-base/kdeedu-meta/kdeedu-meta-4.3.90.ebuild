# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit kde4-functions

DESCRIPTION="KDE educational apps - merge this to pull in all kdeedu-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="4.4"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="aqua kdeprefix"

RDEPEND="
	$(add_kdebase_dep blinken)
	$(add_kdebase_dep cantor)
	$(add_kdebase_dep kalgebra)
	$(add_kdebase_dep kalzium)
	$(add_kdebase_dep kanagram)
	$(add_kdebase_dep kbruch)
	$(add_kdebase_dep kgeography)
	$(add_kdebase_dep khangman)
	$(add_kdebase_dep kig)
	$(add_kdebase_dep kiten)
	$(add_kdebase_dep klettres)
	$(add_kdebase_dep kmplot)
	$(add_kdebase_dep kstars)
	$(add_kdebase_dep ktouch)
	$(add_kdebase_dep kturtle)
	$(add_kdebase_dep kvtml-data)
	$(add_kdebase_dep kwordquiz)
	$(add_kdebase_dep libkdeedu)
	$(add_kdebase_dep marble)
	$(add_kdebase_dep parley)
	$(add_kdebase_dep rocs)
	$(add_kdebase_dep step)
	$(block_other_slots)
"
