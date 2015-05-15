# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5-meta-pkg

DESCRIPTION="KDE educational apps - merge this to pull in all kdeedu-derived packages"
HOMEPAGE="http://edu.kde.org"
KEYWORDS=""
IUSE=""

RDEPEND="
	$(add_kdeapps_dep analitza)
	$(add_kdebase_dep artikulate)
	$(add_kdeapps_dep blinken)
	$(add_kdeapps_dep cantor)
	$(add_kdeapps_dep kalgebra)
	$(add_kdebase_dep kalzium)
	$(add_kdeapps_dep kanagram)
	$(add_kdeapps_dep kbruch)
	$(add_kdeapps_dep kdeedu-data)
	$(add_kdeapps_dep kgeography)
	$(add_kdeapps_dep khangman)
	$(add_kdeapps_dep kig)
	$(add_kdeapps_dep kiten)
	$(add_kdeapps_dep klettres)
	$(add_kdeapps_dep kmplot)
	$(add_kdebase_dep kqtquickcharts)
	$(add_kdeapps_dep kstars)
	$(add_kdebase_dep ktouch)
	$(add_kdeapps_dep kturtle)
	$(add_kdeapps_dep kwordquiz)
	$(add_kdebase_dep libkdeedu)
	$(add_kdeapps_dep libkeduvocdocument)
	$(add_kdebase_dep marble)
	$(add_kdebase_dep pairs)
	$(add_kdeapps_dep parley)
	$(add_kdeapps_dep rocs)
	$(add_kdeapps_dep step)
"
