# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit kde5-meta-pkg

DESCRIPTION="kdeutils - merge this to pull in all kdeutils-derived packages"
HOMEPAGE="https://www.kde.org/applications/utilities https://utils.kde.org"
KEYWORDS=""
IUSE="cups floppy +qt4 lirc pim-conflict"

RDEPEND="
	$(add_kdeapps_dep ark)
	$(add_kdeapps_dep filelight)
	$(add_kdeapps_dep kcalc)
	$(add_kdeapps_dep kcharselect)
	$(add_kdeapps_dep kdebugsettings)
	$(add_kdeapps_dep kteatime)
	$(add_kdeapps_dep ktimer)
	$(add_kdeapps_dep kwalletmanager)
	cups? ( $(add_kdeapps_dep print-manager) )
	floppy? ( $(add_kdeapps_dep kfloppy) )
	qt4? (
		$(add_kdeapps_dep kdf)
		$(add_kdeapps_dep sweeper)
		lirc? ( $(add_kdeapps_dep kremotecontrol) )
		pim-conflict? ( $(add_kdeapps_dep kgpg) )
	)
"
