# Copyright 1999-2015 Gentoo Foundation
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
	$(add_frameworks_dep kcmutils)
	$(add_frameworks_dep kcodecs)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kitemviews)
	$(add_frameworks_dep kwallet)
	$(add_kdeapps_dep akonadi)
	$(add_kdeapps_dep kcontacts)
	$(add_kdeapps_dep kldap)
	$(add_kdeapps_dep kmime)
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
"
DEPEND="${COMMON_DEPEND}
	sys-devel/gettext
"
RDEPEND="${COMMON_DEPEND}
	!<kde-apps/kdepim-15.08.50:5
	!kde-base/kdepim-common-libs:4
	!kde-base/libkdepim:4
"

S="${WORKDIR}/${P}/${PN}"
