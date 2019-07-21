# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_TEST="forceoptional"
KDE_HANDBOOK="optional"
inherit kde5

DESCRIPTION="Tiny Qt music player by KDE"
HOMEPAGE="https://milohr.github.io/BabeIt/"
LICENSE="GPL-3+"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep ki18n)
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtmultimedia)
	$(add_qt_dep qtnetwork)
	$(add_qt_dep qtsql)
	$(add_qt_dep qtwidgets)
	$(add_qt_dep qtxml)
	media-libs/taglib
"
RDEPEND="${DEPEND}"

RESTRICT+=" test"
