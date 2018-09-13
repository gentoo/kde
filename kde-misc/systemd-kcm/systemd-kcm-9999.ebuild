# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit kde5

DESCRIPTION="Plasma control module for systemd"
HOMEPAGE="https://cgit.kde.org/systemd-kcm.git"

IUSE=""
LICENSE="GPL-2+"
KEYWORDS=""

BDEPEND="sys-devel/gettext"
DEPEND="
	$(add_frameworks_dep kauth)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kcrash)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtwidgets)
	sys-apps/systemd
"
RDEPEND="${DEPEND}"
