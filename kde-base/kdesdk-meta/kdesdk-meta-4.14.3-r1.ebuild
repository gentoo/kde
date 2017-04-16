# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit kde4-meta-pkg

DESCRIPTION="KDE SDK - merge this to pull in all kdesdk-derived packages"
HOMEPAGE="http://www.kde.org/applications/development"
KEYWORDS="~amd64 ~x86"
IUSE="cvs"

RDEPEND="
	$(add_kdeapps_dep dolphin-plugins)
	$(add_kdebase_dep kapptemplate)
	$(add_kdebase_dep kate)
	$(add_kdeapps_dep kcachegrind)
	$(add_kdeapps_dep kde-dev-scripts)
	$(add_kdeapps_dep kde-dev-utils)
	$(add_kdeapps_dep kdesdk-kioslaves)
	$(add_kdeapps_dep kompare)
	$(add_kdeapps_dep libkomparediff2)
	$(add_kdeapps_dep lokalize)
	$(add_kdebase_dep okteta)
	$(add_kdeapps_dep poxml)
	$(add_kdeapps_dep umbrello)
	cvs? ( $(add_kdeapps_dep cervisia) )
"
