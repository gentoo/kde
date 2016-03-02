# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_TEST="true"
KMNAME="kdepim"
inherit kde5

DESCRIPTION="Message composer for KMail"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

COMMON_DEPEND="
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep ki18n)
	$(add_kdeapps_dep akonadi-mime)
	$(add_kdeapps_dep kidentitymanagement)
	$(add_kdeapps_dep kldap)
	$(add_kdeapps_dep kmailtransport)
	$(add_kdeapps_dep kmime)
	$(add_kdeapps_dep kpimtextedit)
	$(add_kdeapps_dep libakonadi)
	$(add_kdeapps_dep libfollowupreminder)
	$(add_kdeapps_dep libkdepim)
	$(add_kdeapps_dep libkleo)
	$(add_kdeapps_dep libsendlater)
	$(add_kdeapps_dep messagecore)
	$(add_kdeapps_dep messageviewer)
	$(add_kdeapps_dep pimcommon)
	$(add_kdeapps_dep templateparser)
	dev-libs/grantlee:5
	$(add_qt_dep designer)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtwebkit)
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
