# Copyright 2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
inherit kde5

SRC_URI="http://prdownloads.sourceforge.net/${PN}/${PN}-${PV}.tar.xz"
DESCRIPTION="Function (FN) key monitoring for Toshiba laptops"
HOMEPAGE="http://ktoshiba.sourceforge.net/"
LICENSE="GPL-2"

SLOT="5"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="
	$(add_qt_dep qtcore)
	$(add_qt_dep qtwidgets)
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtgui)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kauth)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kcmutils)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep kconfig)
	sys-devel/gettext
	virtual/pkgconfig
	net-libs/libmnl
"

DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DLIBMNL_INCLUDE_DIRS=/usr/include/libmnl
	)
	kde5_src_configure
}
