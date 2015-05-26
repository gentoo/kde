# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5-meta-pkg

DESCRIPTION="Merge this to pull in all kdebase-derived packages"
KEYWORDS=""
IUSE="+wallpapers"

RDEPEND="
	$(add_kdebase_dep dolphin)
	$(add_kdeapps_dep kdebase-runtime-meta)
	$(add_kdebase_dep kdialog)
	$(add_kdebase_dep keditbookmarks)
	$(add_kdebase_dep kfind)
	$(add_kdebase_dep kfmclient)
	$(add_kdebase_dep konq-plugins)
	$(add_kdebase_dep konqueror)
	$(add_kdeapps_dep konsole)
	$(add_kdeapps_dep kwrite)
	$(add_kdebase_dep libkonq)
	$(add_kdebase_dep nsplugins)
	$(add_kdebase_dep plasma-apps)
	wallpapers? ( $(add_kdebase_dep kde-wallpapers) )
"
