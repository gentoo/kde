# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_HANDBOOK="true"
inherit kde5

DESCRIPTION="KDE image scanning application"
HOMEPAGE="https://www.kde.org/applications/graphics/skanlite"

LICENSE="|| ( GPL-2 GPL-3 ) handbook? ( FDL-1.2+ )"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kjobwidgets)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_kdeapps_dep libksane)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtwidgets)
	media-libs/libpng:0=
"
RDEPEND="${DEPEND}"

src_prepare() {
	kde5_src_prepare
	cmake_comment_add_subdirectory autotests
	cmake_comment_add_subdirectory tests
	use handbook || sed -i -e "/DocTools/d" CMakeLists.txt || die
}
