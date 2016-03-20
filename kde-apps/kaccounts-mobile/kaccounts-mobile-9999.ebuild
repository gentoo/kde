# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit kde5

DESCRIPTION="KDE accounts providers"
HOMEPAGE="https://community.kde.org/KTp"
LICENSE="LGPL-2.1"

KEYWORDS=""
IUSE="google"

COMMON_DEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_kdeapps_dep kcontacts)
	$(add_qt_dep qtdeclarative)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtnetwork)
	$(add_qt_dep qtxml)
	net-libs/accounts-qt
	net-libs/signond
	google? (
		$(add_qt_dep qtwebkit)
		net-libs/libkgapi:5
	)
"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
"
RDEPEND="${COMMON_DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package google KF5GAPI)
		$(cmake-utils_use_find_package google Qt5WebKitWidgets)
	)

	kde5_src_configure
}
