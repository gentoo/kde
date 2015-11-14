# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_DOC_DIR=docs
KDE_HANDBOOK=true
KDE_TEST=true
KMNAME=kdepimlibs
VIRTUALX_REQUIRED=test
inherit kde5

DESCRIPTION="Kioslave plugins for various PIM apps"
KEYWORDS=""
LICENSE="LGPL-2.1"
IUSE="ssl"

COMMON_DEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_kdeapps_dep kldap)
	$(add_kdeapps_dep kmbox)
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	ssl? ( dev-libs/cyrus-sasl )
"
DEPEND="${COMMON_DEPEND}
	sys-devel/gettext
"
RDEPEND="${COMMON_DEPEND}
	!kde-apps/kdepimlibs
	!kde-base/kdepimlibs:4
"

S="${WORKDIR}/${P}/kioslave"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package ssl Sasl2)
		$(cmake-utils_use_build test TESTING)
	)
	kde5_src_configure
}
