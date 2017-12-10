# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

QT_MINIMAL="5.9.1"
KDE_TEST="forceoptional"
KDE_HANDBOOK="optional"
inherit kde5

DESCRIPTION="Simple music player by KDE"
HOMEPAGE="https://community.kde.org/Elisa"
LICENSE="LGPL-3+"
KEYWORDS=""
IUSE="mpris semantic-desktop"

COMMON_DEPEND="
	$(add_frameworks_dep kcmutils)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kcrash)
	$(add_frameworks_dep kdeclarative)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kxmlgui)
	$(add_qt_dep qtdeclarative)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtmultimedia)
	$(add_qt_dep qtsql)
	$(add_qt_dep qtwidgets)
	mpris? (
		$(add_frameworks_dep kdbusaddons)
		$(add_qt_dep qtdbus)
	)
	semantic-desktop? (
		$(add_frameworks_dep baloo)
		$(add_frameworks_dep kfilemetadata)
	)
"
DEPEND="${COMMON_DEPEND}
	sys-devel/gettext
"
RDEPEND="${COMMON_DEPEND}
	$(add_qt_dep qtgraphicaleffects)
	$(add_qt_dep qtquickcontrols)
	$(add_qt_dep qtquickcontrols2)
"

RESTRICT+=" test"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package mpris KF5DBusAddons)
		$(cmake-utils_use_find_package semantic-desktop KF5Baloo)
		$(cmake-utils_use_find_package semantic-desktop KF5FileMetaData)
	)

	kde5_src_configure
}
