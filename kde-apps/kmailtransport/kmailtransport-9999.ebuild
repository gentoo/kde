# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_TEST="true"
inherit kde5

DESCRIPTION="Mail transport service"
LICENSE="GPL-2"
KEYWORDS=""
IUSE=""

RDEPEND="
	$(add_frameworks_dep kcmutils)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep kwallet)
	$(add_kdeapps_dep kdepimlibs)
	$(add_kdeapps_dep kmime)
"
DEPEND="${RDEPEND}"

RESTRICT="test"
