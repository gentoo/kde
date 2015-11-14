# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_HANDBOOK="true"
KDE_TEST="true"
inherit kde5

DESCRIPTION="Interface to work with Graph Theory"
HOMEPAGE="https://www.kde.org/applications/education/rocs
https://edu.kde.org/applications/mathematics/rocs"
KEYWORDS=""
IUSE=""

RDEPEND="
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kcrash)
	$(add_frameworks_dep kdeclarative)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kitemviews)
	$(add_frameworks_dep kparts)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep ktexteditor)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kxmlgui)
	dev-libs/grantlee:5
	dev-qt/qtconcurrent:5
	dev-qt/qtdeclarative:5[widgets]
	dev-qt/qtgui:5
	dev-qt/qtscript:5[scripttools]
	dev-qt/qtsvg:5
	dev-qt/qtwebkit:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	dev-qt/qtxmlpatterns:5
"
DEPEND="${RDEPEND}
	>=dev-libs/boost-1.49
"

RESTRICT=test	# 1/10 tests currently fails

src_prepare() {
	# Duplicate
	sed -e '/^find_package.*KF5DocTools/ s/^/#/' -i CMakeLists.txt || die

	kde5_src_prepare
}
