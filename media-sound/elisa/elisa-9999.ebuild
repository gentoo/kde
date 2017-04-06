# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

KDE_TEST="forceoptional"
KDE_HANDBOOK="optional"
inherit kde5

DESCRIPTION="Simple music player by KDE"
HOMEPAGE="https://community.kde.org/Elisa"
LICENSE="LGPL-3+"
KEYWORDS=""
IUSE=""

# TODO:
# - Bogus deps
# - optional features
RDEPEND="
	$(add_frameworks_dep baloo)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kcrash)
	$(add_frameworks_dep kdeclarative)
	$(add_frameworks_dep kfilemetadata)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kxmlgui)
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtdeclarative)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtmultimedia)
	$(add_qt_dep qtsql)
	$(add_qt_dep qtwidgets)
"
DEPEND="${RDEPEND}
	sys-devel/gettext
"
