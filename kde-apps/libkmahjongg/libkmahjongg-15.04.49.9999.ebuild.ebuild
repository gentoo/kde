# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5

DESCRIPTION="LibKMahjongg for KDE"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kwidgetsaddons)
	dev-qt/qtgui:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
"

RDEPEND="${DEPEND}"

src_prepare() {
	# fix copy-paste (?) error, there are no tests
	sed -i "/find_package(Qt5/ s/ Test//" CMakeLists.txt || die

	kde5_src_prepare
}