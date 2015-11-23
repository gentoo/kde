# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_DOXYGEN="true"
KDE_TEST="true"
VIRTUALX_REQUIRED="test"
inherit kde5

DESCRIPTION="Address book API for KDE"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

RDEPEND="
	$(add_frameworks_dep kcodecs)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep ki18n)
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
"
DEPEND="${RDEPEND}"

src_prepare() {
	kde5_src_prepare

	# FIXME: Fails test because access to /dev/dri/card0 is denied
	sed -i \
		-e "/ecm_add_tests/ s/picturetest\.cpp //" \
		autotests/CMakeLists.txt || die
}
