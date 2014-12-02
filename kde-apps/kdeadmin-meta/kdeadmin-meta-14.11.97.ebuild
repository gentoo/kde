# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5-meta-pkg

DESCRIPTION="KDE administration tools - merge this to pull in all kdeadmin-derived packages"
KEYWORDS=" ~amd64 ~x86"
IUSE=""

RDEPEND="
	$(add_kdeapps_dep kcron)
	$(add_kdeapps_dep ksystemlog)
	$(add_kdeapps_dep kuser)
"
