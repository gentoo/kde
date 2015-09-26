# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_DOXYGEN="true"
KDE_TEST="false"
KMNAME="kdepim"
inherit kde5

DESCRIPTION="Calendar support library"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

COMMON_DEPEND="
	$(add_frameworks_dep kcodecs)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep kguiaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kjobwidgets)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_kdeapps_dep akonadi)
	$(add_kdeapps_dep akonadi-calendar)
	$(add_kdeapps_dep akonadi-mime)
	$(add_kdeapps_dep kcalcore)
	$(add_kdeapps_dep kcalutils)
	$(add_kdeapps_dep kholidays)
	$(add_kdeapps_dep kidentitymanagement)
	$(add_kdeapps_dep kmime)
	$(add_kdeapps_dep libakonadi)
	$(add_kdeapps_dep libkdepim)
	$(add_kdeapps_dep libkdepimdbusinterfaces)
	$(add_kdeapps_dep pimcommon)
	dev-libs/libical
	dev-qt/designer:5
	dev-qt/qtgui:5
	dev-qt/qtprintsupport:5
	dev-qt/qtwidgets:5
"
DEPEND="${COMMON_DEPEND}
	sys-devel/gettext
"
RDEPEND="${COMMON_DEPEND}
	!<kde-apps/kdepim-15.08.50:5
	!kde-base/kdepim-common-libs:4
"

S="${WORKDIR}/${P}/${PN}"
