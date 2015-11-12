# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit kde5

DESCRIPTION="Client library to access and handling of KAlarm calendar data"
KEYWORDS=" ~amd64 ~x86"
IUSE=""

RDEPEND="
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep ki18n)
	$(add_kdeapps_dep kcalcore)
	$(add_kdeapps_dep kdepimlibs)
	$(add_kdeapps_dep kholidays)
	$(add_kdeapps_dep kidentitymanagement)
	dev-qt/qtgui:5
"
DEPEND="${RDEPEND}
	sys-devel/gettext
"
