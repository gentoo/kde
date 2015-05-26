# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5-meta-pkg

DESCRIPTION="kdegames - merge this to pull in all kdegames-derived packages"
HOMEPAGE="http://games.kde.org/"
KEYWORDS=" ~amd64 ~x86"
IUSE="opengl python"

RDEPEND="
	$(add_kdeapps_dep bomber)
	$(add_kdeapps_dep bovo)
	$(add_kdeapps_dep granatier)
	$(add_kdeapps_dep kapman)
	$(add_kdeapps_dep katomic)
	$(add_kdeapps_dep kblackbox)
	$(add_kdeapps_dep kblocks)
	$(add_kdeapps_dep kbounce)
	$(add_kdeapps_dep kbreakout)
	$(add_kdeapps_dep kdiamond)
	$(add_kdeapps_dep kfourinline)
	$(add_kdebase_dep kgoldrunner)
	$(add_kdebase_dep kigo)
	$(add_kdeapps_dep killbots)
	$(add_kdebase_dep kiriki)
	$(add_kdeapps_dep kjumpingcube)
	$(add_kdebase_dep klickety)
	$(add_kdeapps_dep klines)
	$(add_kdebase_dep kmahjongg)
	$(add_kdeapps_dep kmines)
	$(add_kdebase_dep knavalbattle)
	$(add_kdeapps_dep knetwalk)
	$(add_kdebase_dep kolf)
	$(add_kdeapps_dep kollision)
	$(add_kdebase_dep konquest)
	$(add_kdeapps_dep kpat)
	$(add_kdebase_dep kreversi)
	$(add_kdeapps_dep kshisen)
	$(add_kdebase_dep ksirk)
	$(add_kdebase_dep ksnakeduel)
	$(add_kdebase_dep kspaceduel)
	$(add_kdeapps_dep ksquares)
	$(add_kdebase_dep ktuberling)
	$(add_kdebase_dep kubrick)
	$(add_kdeapps_dep libkdegames)
	$(add_kdeapps_dep libkmahjongg)
	$(add_kdebase_dep lskat)
	$(add_kdebase_dep palapeli)
	$(add_kdebase_dep picmi)
	opengl? ( $(add_kdebase_dep ksudoku) )
	python? ( $(add_kdebase_dep kajongg) )
"
