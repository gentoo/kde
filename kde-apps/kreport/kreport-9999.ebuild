# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_TEST="true"
inherit kde5

DESCRIPTION="Framework for creation and generation of reports in multiple formats"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kguiaddons)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kross)
	$(add_kdeapps_dep kproperty)
	dev-qt/qtgui:5
	dev-qt/qtprintsupport:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
"

RDEPEND="${DEPEND}"
