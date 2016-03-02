# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

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
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtgui)
"
DEPEND="${RDEPEND}"

src_prepare() {
	kde5_src_prepare

	# FIXME: Fails test because access to /dev/dri/card0 is denied
	sed -i \
		-e "/ecm_add_tests/ s/picturetest\.cpp //" \
		autotests/CMakeLists.txt || die
}
