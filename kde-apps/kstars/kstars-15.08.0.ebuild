# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_HANDBOOK="true"
PYTHON_COMPAT=( python2_7 )
inherit kde5 python-single-r1

DESCRIPTION="Desktop Planetarium"
HOMEPAGE="http://www.kde.org/applications/education/kstars http://edu.kde.org/kstars"
KEYWORDS="~amd64 ~x86"
IUSE="fits indi wcs xplanet"

REQUIRED_USE="indi? ( fits )"

# TODO: AstrometryNet requires new package
# FIXME: doesn't build without sci-libs/cfitsio as of 15.04.0
DEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kguiaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kinit)
	$(add_frameworks_dep kjobwidgets)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep knewstuff)
	$(add_frameworks_dep kplotting)
	$(add_frameworks_dep ktexteditor)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep kxmlgui)
	dev-cpp/eigen:3
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtmultimedia:5
	dev-qt/qtopengl:5
	dev-qt/qtprintsupport:5
	dev-qt/qtscript:5
	dev-qt/qtsql:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	>=sci-libs/cfitsio-0.390
	sys-libs/zlib
	indi? ( >=sci-libs/indilib-1.0.0 )
	wcs? ( sci-astronomy/wcslib )
	xplanet? ( x11-misc/xplanet )
"
RDEPEND="${DEPEND}
	${PYTHON_DEPS}
"

# Regression from commit e9f1b544eda238c068fbbbbf612f291c734ea5aa
# Inspiration from https://git.reviewboard.kde.org/r/110787/
PATCHES=( "${FILESDIR}/${PN}-15.04.0-use-python2-explicitly.patch" )

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package indi)
		$(cmake-utils_use_find_package wcs WCSLIB)
		$(cmake-utils_use_find_package xplanet Xplanet)
	)

	kde5_src_configure
}
