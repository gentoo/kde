# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_DOXYGEN="true"
KDE_TEST="true"
inherit kde5

DESCRIPTION="Library for interacting with LDAP servers"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_kdeapps_dep kmbox)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtwidgets)
	dev-libs/cyrus-sasl
	net-nds/openldap
"
RDEPEND="${DEPEND}"
