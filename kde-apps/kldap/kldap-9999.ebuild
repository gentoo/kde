# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_DOXYGEN="true"
KDE_TEST="true"
inherit kde5

DESCRIPTION="Library for interacting with LDAP servers"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

RDEPEND="
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kwidgetsaddons)
	dev-libs/cyrus-sasl
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	net-nds/openldap
"
DEPEND="${RDEPEND}"
