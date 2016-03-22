# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_DOXYGEN="true"
# KDE_HANDBOOK="true"
KDE_TEST="forceoptional"
inherit kde5

DESCRIPTION="Visual database applications creator"
HOMEPAGE="https://www.kde.org/applications/office/kexi/ http://www.kexi-project.org/"
KEYWORDS=""
IUSE="activities marble mdb mysql postgres sqlite sybase webform xbase"

COMMON_DEPEND="
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep kcodecs)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kguiaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kitemviews)
	$(add_frameworks_dep ktexteditor)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_kdeapps_dep kdb 'mysql?,postgres?,sqlite?')
	$(add_kdeapps_dep kproperty)
	$(add_kdeapps_dep kreport)
	$(add_qt_dep designer)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtnetwork)
	$(add_qt_dep qtprintsupport)
	$(add_qt_dep qtwidgets)
	$(add_qt_dep qtxml)
	activities? ( $(add_frameworks_dep kactivities) )
	marble? ( $(add_kdeapps_dep marble) )
	mdb? ( dev-libs/glib:2 )
	mysql? ( virtual/libmysqlclient )
	postgres? (
		dev-db/postgresql:*
		dev-libs/libpqxx
	)
	sybase? ( dev-db/freetds )
	webform? ( $(add_qt_dep qtwebkit) )
	xbase? ( dev-db/xbase )
"
DEPEND="${COMMON_DEPEND}
	sys-devel/gettext
"
RDEPEND="${COMMON_DEPEND}
	!app-office/calligra[calligra_features_kexi]
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package activities KF5Activities)
		$(cmake-utils_use_find_package marble KexiMarble)
		$(cmake-utils_use_find_package mdb GLIB2)
		$(cmake-utils_use_find_package mysql MySQL)
		$(cmake-utils_use_find_package postgres KexiPostgreSQL)
		$(cmake-utils_use_find_package sybase FreeTDS)
		$(cmake-utils_use_find_package webform Qt5WebKitWidgets)
		$(cmake-utils_use_find_package xbase XBase)
	)

	kde5_src_configure
}
