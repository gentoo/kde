# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_TEST="forceoptional"
inherit kde5

DESCRIPTION="Data Model and Extraction System for Travel Reservation information"
HOMEPAGE="https://kde.org/applications/office/kontact/"

LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kcontacts)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kholidays)
	$(add_frameworks_dep ki18n)
	$(add_kdeapps_dep kitinerary)
	$(add_kdeapps_dep kpkpass)
	$(add_qt_dep qtdeclarative)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtnetwork)
	$(add_qt_dep qtpositioning)
	$(add_qt_dep qtwidgets)
	kde-misc/kpublictransport:5
	sys-libs/zlib
"
RDEPEND="${DEPEND}
	$(add_frameworks_dep kirigami)
	$(add_frameworks_dep prison)
	$(add_qt_dep qtquickcontrols2)
	!kde-apps/itinerary
"
