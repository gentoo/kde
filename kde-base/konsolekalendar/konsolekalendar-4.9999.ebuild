# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
KMNAME="kdepim"
KMMODULE="console/${PN}"
inherit kde4-meta

DESCRIPTION="A command line interface to KDE calendars"
HOMEPAGE+=" http://userbase.kde.org/KonsoleKalendar"
KEYWORDS=""
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kdepimlibs)
	$(add_kdebase_dep kdepim-common-libs)
"
RDEPEND="${DEPEND}"

KMCOMPILEONLY="
	calendarsupport/
"
KMEXTRACTONLY="
	calendarviews/
	libkdepimdbusinterfaces/
"

KMLOADLIBS="kdepim-common-libs"
