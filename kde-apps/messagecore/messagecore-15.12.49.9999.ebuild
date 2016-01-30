# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_TEST="true"
KMNAME="kdepim"
inherit kde5

DESCRIPTION="Library for core messaging functions"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

COMMON_DEPEND="
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep kcodecs)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep ki18n)
	$(add_kdeapps_dep akonadi-mime)
	$(add_kdeapps_dep kmime)
	$(add_kdeapps_dep kpimtextedit)
	$(add_kdeapps_dep libakonadi)
	$(add_kdeapps_dep libkleo)
	$(add_qt_dep designer)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtnetwork)
	$(add_qt_dep qtwidgets)
"
DEPEND="${COMMON_DEPEND}
	sys-devel/gettext
"
RDEPEND="${COMMON_DEPEND}
	!<kde-apps/kdepim-15.08.50:5
	!kde-apps/kdepim-common-libs:4
"

if [[ ${KDE_BUILD_TYPE} = live ]] ; then
	S="${WORKDIR}/${P}/${PN}"
else
	S="${WORKDIR}/${KMNAME}-${PV}/${PN}"
fi
