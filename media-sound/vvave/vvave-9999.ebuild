# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit kde5

DESCRIPTION="Tiny Qt music player by KDE"
HOMEPAGE="https://vvave.kde.org/"

LICENSE="GPL-3+"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep attica)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtmultimedia)
	$(add_qt_dep qtnetwork)
	$(add_qt_dep qtquickcontrols2)
	$(add_qt_dep qtsql)
	$(add_qt_dep qtsvg)
	$(add_qt_dep qtwebengine)
	$(add_qt_dep qtwebsockets)
	$(add_qt_dep qtwidgets)
	$(add_qt_dep qtxml)
	dev-libs/mauikit
	media-libs/taglib
"
RDEPEND="${DEPEND}
	$(add_frameworks_dep kirigami)
	$(add_qt_dep qtgraphicaleffects)
	media-plugins/gst-plugins-meta:1.0[ffmpeg,mp3]
"
