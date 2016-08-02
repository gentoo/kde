# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_DOC_DIR="docs"
KDE_HANDBOOK="forceoptional"
KMNAME="kde-baseapps"
inherit kde5

DESCRIPTION="GUI for passwd based on KDE Frameworks"
KEYWORDS=""
IUSE=""

COMMON_DEPEND="
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kdesu)
	$(add_frameworks_dep kdoctools)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtwidgets)
"
DEPEND="${COMMON_DEPEND}
	$(add_frameworks_dep kio)
	$(add_kdeapps_dep libkonq)
"
RDEPEND="${COMMON_DEPEND}
	$(add_plasma_dep kde-cli-tools 'kdesu')
	sys-apps/accountsservice
"

S="${S}/${PN}"
