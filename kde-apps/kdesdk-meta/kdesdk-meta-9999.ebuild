# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5-meta-pkg

DESCRIPTION="KDE SDK - merge this to pull in all kdesdk-derived packages"
HOMEPAGE="http://www.kde.org/applications/development"
KEYWORDS=""
IUSE="cvs"

RDEPEND="
	$(add_kdebase_dep dolphin-plugins)
	$(add_kdeapps_dep kapptemplate)
	$(add_kdeapps_dep kate)
	$(add_kdebase_dep kcachegrind)
	$(add_kdeapps_dep kde-dev-scripts)
	$(add_kdebase_dep kde-dev-utils)
	$(add_kdebase_dep kdesdk-kioslaves)
	$(add_kdeapps_dep kompare)
	$(add_kdeapps_dep libkomparediff2)
	$(add_kdeapps_dep lokalize)
	$(add_kdeapps_dep okteta)
	$(add_kdebase_dep poxml)
	$(add_kdebase_dep umbrello)
	cvs? ( $(add_kdebase_dep cervisia) )
"
