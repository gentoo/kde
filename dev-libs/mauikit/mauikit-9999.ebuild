# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_QTHELP="true"
inherit kde5

DESCRIPTION="Templated convergent controls and multiplatform utilities for Maui applications"

LICENSE="GPL-3"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep attica)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep kservice)
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtdeclarative)
	$(add_qt_dep qtnetwork)
	$(add_qt_dep qtquickcontrols2)
	$(add_qt_dep qtsql)
	$(add_qt_dep qtsvg)
	$(add_qt_dep qtwebengine)
	$(add_qt_dep qtwidgets)
	$(add_qt_dep qtxml)
"
RDEPEND="${DEPEND}
	$(add_frameworks_dep kirigami)
	$(add_qt_dep qtgraphicaleffects)
	$(add_qt_dep qtmultimedia 'qml')
"
