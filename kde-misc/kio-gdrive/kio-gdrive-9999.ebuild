# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_TEST="optional"
inherit kde5

DESCRIPTION="KIO Slave for Google Drive service"
HOMEPAGE="https://phabricator.kde.org/project/profile/72/"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_qt_dep qtwidgets)
	dev-libs/qtkeychain[qt5]
	>=net-libs/libkgapi-5.3.1
"
DEPEND="${RDEPEND}
	$(add_qt_dep qtgui)
	$(add_qt_dep qtnetwork)
"

pkg_postinst() {
	kde5_pkg_postinst

	einfo
	einfo "Usage: Type 'gdrive:/' in dolphin's location bar."
	einfo
}
