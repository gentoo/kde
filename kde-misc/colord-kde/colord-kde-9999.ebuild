# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit kde5

DESCRIPTION="Provides interfaces and session daemon to colord"
HOMEPAGE="http://projects.kde.org/projects/playground/graphics/colord-kde"
#SRC_URI="mirror://kde/stable/${PN}/${PV}/src/${P}.tar.bz2"

LICENSE="GPL-2+"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kcmutils)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep kitemviews)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep plasma)
	media-libs/lcms:2
	dev-qt/qtdbus:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	x11-libs/libxcb
	x11-libs/libX11
"
RDEPEND="${DEPEND}
	x11-misc/colord
"

pkg_postinst() {
	kde5_pkg_postinst
	if ! has_version "gnome-extra/gnome-color-manager"; then
		elog "You may want to install gnome-extra/gnome-color-manager to add support for"
		elog "colorhug calibration devices."
	fi
}
