# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_HANDBOOK="forceoptional"
KDE_PUNT_BOGUS_DEPS="true"
PYTHON_COMPAT=( python2_7 )
inherit kde5 python-single-r1

DESCRIPTION="Desktop Planetarium"
HOMEPAGE="https://www.kde.org/applications/education/kstars https://edu.kde.org/kstars"
KEYWORDS="~amd64 ~x86"
IUSE="indi wcs xplanet"

# TODO: AstrometryNet requires new package
# FIXME: doesn't build without sci-libs/cfitsio as of 15.04.0
COMMON_DEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kguiaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kinit)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep knewstuff)
	$(add_frameworks_dep kplotting)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtprintsupport:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	>=sci-libs/cfitsio-0.390
	sys-libs/zlib
	indi? (
		$(add_frameworks_dep knotifications)
		>=sci-libs/indilib-1.0.0
	)
	wcs? ( sci-astronomy/wcslib )
	xplanet? ( x11-misc/xplanet )
"
DEPEND="${COMMON_DEPEND}
	dev-cpp/eigen:3
"
RDEPEND="${COMMON_DEPEND}
	${PYTHON_DEPS}
"

PATCHES=(
	# Regression from commit e9f1b544eda238c068fbbbbf612f291c734ea5aa
	# Inspiration from https://git.reviewboard.kde.org/r/110787/
	"${FILESDIR}/${PN}-15.04.0-use-python2-explicitly.patch"
	"${FILESDIR}/${PN}-15.12.0-unused-qt-deps.patch"
	"${FILESDIR}/${PN}-15.12.0-unused-kf5-deps.patch"
)

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package indi)
		$(cmake-utils_use_find_package wcs WCSLIB)
		$(cmake-utils_use_find_package xplanet Xplanet)
	)

	kde5_src_configure
}
