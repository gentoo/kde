# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDEBASE="kdevelop"
KMNAME="kdev-php"
VIRTUALX_REQUIRED="test"
inherit kde5

DESCRIPTION="PHP plugin for KDevelop"
LICENSE="GPL-2 LGPL-2"
IUSE=""
KEYWORDS="~amd64"

DEPEND="
	$(add_frameworks_dep kapidox)
	$(add_frameworks_dep kcmutils)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep ktexteditor)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep threadweaver)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtwebkit)
	$(add_qt_dep qtwidgets)
	dev-util/kdevelop-pg-qt:5
	>=dev-util/kdevplatform-${PV}:${SLOT}
"
RDEPEND="${DEPEND}
	!dev-util/kdevelop-php-docs
	dev-util/kdevelop:${SLOT}
"
