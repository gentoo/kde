# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_TEST="optional"
inherit kde5

DESCRIPTION="KIO Slave for Google Drive service"
HOMEPAGE="https://phabricator.kde.org/project/profile/72/"
[[ ${KDE_BUILD_TYPE} != live ]] && SRC_URI="mirror://kde/stable/${PN}/${PV}/src/${P}.tar.xz"

SLOT="0"
[[ ${KDE_BUILD_TYPE} != live ]] && KEYWORDS="~amd64"
IUSE=""

DOCS=( README.md )

COMMON_DEPEND="
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_qt_dep qtwidgets)
	dev-libs/qtkeychain[qt5]
	>=net-libs/libkgapi-5.3.1
"
DEPEND="${COMMON_DEPEND}
	$(add_qt_dep qtgui)
	$(add_qt_dep qtnetwork)
"
RDEPEND="${COMMON_DEPEND}
	$(add_kdeapps_dep dolphin)
"

pkg_postinst() {
	kde5_pkg_postinst
	einfo
	einfo "Either click on 'Google Drive File Manager' in the application"
	einfo "launcher or type 'gdrive:/' in dolphin's location bar."
	einfo
}
