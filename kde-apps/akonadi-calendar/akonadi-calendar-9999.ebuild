# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_TEST="true"
inherit kde5

DESCRIPTION="Library for akonadi calendar integration"
LICENSE="GPL-2+"
KEYWORDS=""
IUSE=""

RDEPEND="
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kitemviews)
	$(add_frameworks_dep kwallet)
	$(add_kdeapps_dep kcalcore)
	$(add_kdeapps_dep kcalutils)
	$(add_kdeapps_dep kcontacts)
	$(add_kdeapps_dep kdepimlibs)
	$(add_kdeapps_dep kidentitymanagement)
	$(add_kdeapps_dep kmailtransport)
"
DEPEND="${RDEPEND}"

RESTRICT="test"
