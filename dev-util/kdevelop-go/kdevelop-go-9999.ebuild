# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

KDEBASE="kdevelop"
KMNAME="kdev-go"
inherit kde5

DESCRIPTION="Go language support for KDevelop"
LICENSE="GPL-2"
KEYWORDS=""
IUSE="test"

COMMON_DEPEND="
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep ktexteditor)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep threadweaver)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtwidgets)
	dev-util/kdevelop:5
"
DEPEND="${COMMON_DEPEND}
	dev-util/kdevelop-pg-qt:5
	test? ( dev-util/kdevelop:5[test] )
"
RDEPEND="${COMMON_DEPEND}
	dev-lang/go
"

DOCS=( README.md )
