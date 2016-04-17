# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_DOXYGEN="true"
KDE_HANDBOOK="forceoptional"
KDE_TEST="true"
QT_MINIMAL="5.6.0"
inherit kde5

DESCRIPTION="Library for interacting with LDAP servers"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE="ssl"

DEPEND="
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_kdeapps_dep kmbox)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtwidgets)
	net-nds/openldap
	ssl? ( dev-libs/cyrus-sasl )
"
RDEPEND="${DEPEND}
	!<kde-apps/kdepim-kioslaves-16.04.50
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package ssl Sasl2)
	)
	kde5_src_configure
}
