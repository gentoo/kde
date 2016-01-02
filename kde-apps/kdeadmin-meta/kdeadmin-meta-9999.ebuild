# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit kde5-meta-pkg

DESCRIPTION="KDE administration tools - merge this to pull in all kdeadmin-derived packages"
KEYWORDS=""
IUSE="+cron"

RDEPEND="
	$(add_kdeapps_dep ksystemlog)
	$(add_kdeapps_dep kuser)
	cron? ( $(add_kdeapps_dep kcron) )
"
