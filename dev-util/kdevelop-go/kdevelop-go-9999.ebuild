# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDEBASE="kdevelop"
KMNAME="kdev-go"
inherit kde5

DESCRIPTION="Go language support for KDevelop"
LICENSE="GPL-2"
KEYWORDS=""
IUSE=""

COMMON_DEPEND="
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep ktexteditor)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep threadweaver)
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-util/kdevplatform:5
"
DEPEND="${COMMON_DEPEND}
	dev-util/kdevelop-pg-qt:5
"
RDEPEND="${COMMON_DEPEND}
	dev-lang/go
	dev-util/kdevelop:5
"

DOCS=( README.md )
