# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_GCC_MINIMAL="4.9"
KDE_HANDBOOK="forceoptional"
QT_MINIMAL="5.5.1"
inherit kde5

DESCRIPTION="Free/Open Source micro-blogging client for KDE"
HOMEPAGE="http://choqok.gnufolks.org/"

LICENSE="GPL-2+"
IUSE="attica konqueror"

DEPEND="
	$(add_frameworks_dep kcmutils)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kemoticons)
	$(add_frameworks_dep kglobalaccel)
	$(add_frameworks_dep kguiaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kjobwidgets)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep knotifyconfig)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwallet)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep sonnet)
	app-crypt/qca[qt5]
	dev-libs/qjson
	dev-libs/qoauth:5
	dev-qt/qtconcurrent:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwebkit:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	net-libs/telepathy-qt[qt5]
	attica? ( dev-libs/libattica )
	konqueror? (
		$(add_frameworks_dep kparts)
		$(add_frameworks_dep kdewebkit)
	)
"
RDEPEND="${DEPEND}
	!net-im/choqok:4
"

DOCS=( AUTHORS README TODO changelog )

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package attica KF5Attica)
		$(cmake-utils_use_find_package konqueror KF5Parts)
		$(cmake-utils_use_find_package konqueror KF5WebKit)
	)

	kde5_src_configure
}
