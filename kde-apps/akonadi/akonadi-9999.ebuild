# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

QT_MINIMAL="5.4.0"
KMNAME="kdepimlibs"
inherit kde5

DESCRIPTION="Akonadi library for KDE PIM apps"
KEYWORDS=""
LICENSE="LGPL-2.1"
IUSE="test"
RESTRICT="test"

DEPEND="
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kitemmodels)
	$(add_frameworks_dep kitemviews)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtsql:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	app-office/akonadi-server
	dev-libs/boost
	dev-libs/libxml2
"
RDEPEND="${DEPEND}"

S="${S}"/${PN}

src_prepare() {
	if ! use test; then
		find -name CMakeLists.txt -exec sed -i -e 's/add_subdirectory(autotests)//' -e 's/add_subdirectory(tests)//' {} \; || die "couldn't remove autotests"
	fi
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_build test TESTING)
	)
	kde5_src_configure
}
