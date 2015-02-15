# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegames-meta/kdegames-meta-4.14.3.ebuild,v 1.3 2015/02/14 14:35:12 ago Exp $

EAPI=5
inherit kde4-meta-pkg

DESCRIPTION="kdegames - merge this to pull in all kdegames-derived packages"
HOMEPAGE="http://games.kde.org/"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="opengl python"

RDEPEND="
	$(add_kdebase_dep bomber)
	$(add_kdebase_dep bovo)
	$(add_kdebase_dep granatier)
	$(add_kdebase_dep kapman)
	$(add_kdebase_dep katomic)
	$(add_kdebase_dep kblackbox)
	$(add_kdebase_dep kblocks)
	$(add_kdebase_dep kbounce)
	$(add_kdebase_dep kbreakout)
	$(add_kdebase_dep kdiamond)
	$(add_kdebase_dep kfourinline)
	$(add_kdebase_dep kgoldrunner)
	$(add_kdebase_dep killbots)
	$(add_kdebase_dep kigo)
	$(add_kdebase_dep kiriki)
	$(add_kdebase_dep kjumpingcube)
	$(add_kdebase_dep klickety)
	$(add_kdebase_dep klines)
	$(add_kdebase_dep kmahjongg)
	$(add_kdebase_dep kmines)
	$(add_kdebase_dep knavalbattle)
	$(add_kdebase_dep knetwalk)
	$(add_kdebase_dep kolf)
	$(add_kdebase_dep kollision)
	$(add_kdebase_dep konquest)
	$(add_kdebase_dep kpat)
	$(add_kdebase_dep kreversi)
	$(add_kdebase_dep kshisen)
	$(add_kdebase_dep ksirk)
	$(add_kdebase_dep ksnakeduel)
	$(add_kdebase_dep kspaceduel)
	$(add_kdebase_dep ksquares)
	$(add_kdebase_dep ktuberling)
	$(add_kdebase_dep kubrick)
	$(add_kdebase_dep libkdegames)
	$(add_kdebase_dep libkmahjongg)
	$(add_kdebase_dep lskat)
	$(add_kdebase_dep palapeli)
	$(add_kdebase_dep picmi)
	opengl? ( $(add_kdebase_dep ksudoku) )
	python? ( $(add_kdebase_dep kajongg) )
"
