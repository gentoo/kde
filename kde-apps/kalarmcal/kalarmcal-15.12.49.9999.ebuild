# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit kde5

DESCRIPTION="Client library to access and handling of KAlarm calendar data"
KEYWORDS=""
IUSE=""

RDEPEND="
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep ki18n)
	$(add_kdeapps_dep kcalcore)
	$(add_kdeapps_dep kholidays)
	$(add_kdeapps_dep kidentitymanagement)
	$(add_kdeapps_dep libakonadi)
	$(add_qt_dep qtgui)
"
DEPEND="${RDEPEND}
	sys-devel/gettext
"
