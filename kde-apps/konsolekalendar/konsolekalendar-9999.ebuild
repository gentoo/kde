# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_HANDBOOK="forceoptional"
KMNAME="akonadi-calendar-tools"
inherit kde5

DESCRIPTION="Command line interface to KDE calendars"
HOMEPAGE+=" https://userbase.kde.org/KonsoleKalendar"
LICENSE="GPL-2+ handbook? ( FDL-1.2+ )"
KEYWORDS=""

IUSE=""

DEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep ki18n)
	$(add_kdeapps_dep akonadi)
	$(add_kdeapps_dep akonadi-calendar)
	$(add_kdeapps_dep calendarsupport)
	$(add_kdeapps_dep kcalcore)
	$(add_kdeapps_dep kcalutils)
"
RDEPEND="${DEPEND}"

src_prepare() {
	cmake_comment_add_subdirectory calendarjanitor
	kde5_src_prepare
}
