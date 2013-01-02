# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit kde4-meta-pkg

DESCRIPTION="KDE SDK - merge this to pull in all kdesdk-derived packages"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="cvs"

RDEPEND="
	cvs? ( $(add_kdebase_dep cervisia) )
	$(add_kdebase_dep dolphin-plugins)
	$(add_kdebase_dep kapptemplate)
	$(add_kdebase_dep kate)
	$(add_kdebase_dep kcachegrind)
	$(add_kdebase_dep kdesdk-kioslaves)
	$(add_kdebase_dep kdesdk-misc)
	$(add_kdebase_dep kdesdk-scripts)
	$(add_kdebase_dep kdesdk-strigi-analyzer)
	$(add_kdebase_dep kompare)
	$(add_kdebase_dep kstartperf)
	$(add_kdebase_dep kuiviewer)
	$(add_kdebase_dep lokalize)
	$(add_kdebase_dep okteta)
	$(add_kdebase_dep umbrello)
"
