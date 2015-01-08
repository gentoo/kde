# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5-meta-pkg

DESCRIPTION="Merge this to pull in all kdebase-derived packages"
KEYWORDS=""
IUSE="+wallpapers"

RDEPEND="
	$(add_kdeapps_dep dolphin)
	$(add_kdeapps_dep kdebase-runtime-meta)
	$(add_kdeapps_dep kdialog)
	$(add_kdeapps_dep keditbookmarks)
	$(add_kdeapps_dep kfind)
	$(add_kdeapps_dep kfmclient)
	$(add_kdeapps_dep konq-plugins)
	$(add_kdeapps_dep konqueror)
	$(add_kdeapps_dep konsole)
	$(add_kdeapps_dep kwrite)
	$(add_kdeapps_dep libkonq)
	$(add_kdeapps_dep nsplugins)
	$(add_kdeapps_dep plasma-apps)
	wallpapers? ( $(add_kdeapps_dep kde-wallpapers) )
"
