# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDEBASE="kdevelop"
KMNAME="kdev-upload"
inherit kde5

DESCRIPTION="Plugin for uploading files to a remote server"
LICENSE="GPL-2"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kcmutils)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kitemmodels)
	$(add_frameworks_dep kjobwidgets)
	$(add_frameworks_dep kparts)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep ktexteditor)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtwidgets)
	dev-util/kdevplatform:5
"
RDEPEND="${DEPEND}
	dev-util/kdevelop:5
"

src_configure() {
	append-cppflags -I/usr/include/KF5/KDELibs4Support
	kde5_src_configure
}
