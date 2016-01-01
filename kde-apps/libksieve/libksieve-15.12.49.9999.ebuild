# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_TEST="true"
KMNAME="kdepim"
inherit kde5

DESCRIPTION="Common PIM libraries"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

COMMON_DEPEND="
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep knewstuff)
	$(add_frameworks_dep kwindowsystem)
	$(add_kdeapps_dep akonadi)
	$(add_kdeapps_dep kidentitymanagement)
	$(add_kdeapps_dep kmailtransport)
	$(add_kdeapps_dep kpimtextedit)
	$(add_kdeapps_dep libkdepim)
	$(add_kdeapps_dep pimcommon)
	dev-qt/designer:5
	dev-qt/qtgui:5
	dev-qt/qtwebkit:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
"
DEPEND="${COMMON_DEPEND}
	sys-devel/gettext
"
RDEPEND="${COMMON_DEPEND}
	!<kde-apps/kdepim-15.08.50:5
	!kde-apps/kmail:4
"

if [[ ${KDE_BUILD_TYPE} = live ]] ; then
	S="${WORKDIR}/${P}/${PN}"
else
	S="${WORKDIR}/${KMNAME}-${PV}/${PN}"
fi
