# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_HANDBOOK="true"
KDE_TEST="true"
inherit kde5

DESCRIPTION="Interactive physics simulator"
HOMEPAGE="https://edu.kde.org/step"
KEYWORDS=""
IUSE="+gsl +qalculate"

DEPEND="
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep khtml)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep knewstuff)
	$(add_frameworks_dep kparts)
	$(add_frameworks_dep kplotting)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	=dev-cpp/eigen-3.2*:3
	$(add_qt_dep qtdeclarative)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtopengl)
	$(add_qt_dep qtprintsupport)
	$(add_qt_dep qtsvg)
	$(add_qt_dep qtwidgets)
	$(add_qt_dep qtxml)
	sci-libs/cln
	gsl? ( >=sci-libs/gsl-1.9-r1 )
	qalculate? ( >=sci-libs/libqalculate-0.9.5 )
"
RDEPEND="${DEPEND}"

src_prepare() {
	use handbook || sed -e '/^find_package.*KF5DocTools/ s/^/#/' \
		-i CMakeLists.txt || die

	# Duplicate
	sed -e '/^find_package.*Qt5Test/ s/^/#/' \
		-i autotests/CMakeLists.txt || die
	sed -e '/find_package.*Xml Test/ s/^/#/' \
		-i stepcore/CMakeLists.txt || die

	kde5_src_prepare
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package gsl)
		$(cmake-utils_use_find_package qalculate)
	)
	kde5_src_configure
}
