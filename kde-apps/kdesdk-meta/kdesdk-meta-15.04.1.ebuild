# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5-meta-pkg

DESCRIPTION="KDE SDK - merge this to pull in all kdesdk-derived packages"
HOMEPAGE="http://www.kde.org/applications/development"
KEYWORDS=" ~amd64 ~x86"
IUSE="cvs"

RDEPEND="
	|| (
		( 	$(add_kdebase_dep dolphin-plugins)
			kde-base/kompare:4
			kde-base/libkomparediff2:4	)
		(	$(add_kdeapps_dep kompare)
			$(add_kdeapps_dep libkomparediff2)	)
	)
	$(add_kdeapps_dep kapptemplate)
	$(add_kdeapps_dep kate)
	$(add_kdebase_dep kcachegrind)
	$(add_kdebase_dep kde-dev-scripts)
	$(add_kdebase_dep kde-dev-utils)
	$(add_kdebase_dep kdesdk-kioslaves)
	$(add_kdeapps_dep lokalize)
	$(add_kdeapps_dep okteta)
	$(add_kdebase_dep poxml)
	$(add_kdebase_dep umbrello)
	cvs? ( $(add_kdebase_dep cervisia) )
"
