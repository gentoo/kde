# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_PUNT_BOGUS_DEPS="true"
KDE_TEST="false"
KMNAME="kdepim"
QT_MINIMAL="5.6.0"
inherit kde5

DESCRIPTION="A tool to scan calendar data for buggy instances"
HOMEPAGE="https://www.kde.org/"
KEYWORDS=""

IUSE=""

DEPEND="
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep ki18n)
	$(add_kdeapps_dep akonadi)
	$(add_kdeapps_dep akonadi-calendar)
	$(add_kdeapps_dep calendarsupport)
	$(add_kdeapps_dep kcalcore)
	$(add_qt_dep qtwidgets)
	dev-libs/libxslt
"
RDEPEND="${DEPEND}
	!<kde-apps/kdepim-15.12.2:5
"

if [[ ${KDE_BUILD_TYPE} = live ]] ; then
	S="${WORKDIR}/${P}/console"
else
	S="${WORKDIR}/${KMNAME}-${PV}/console"
fi

src_prepare() {
	cmake_comment_add_subdirectory konsolekalendar
	kde5_src_prepare
}
