# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_BRANCH="frameworks"
inherit kde5

DESCRIPTION="KDE systemsettings kcm to set GTK application look&feel"
HOMEPAGE="http://projects.kde.org/kde-gtk-config"
LICENSE="GPL-3"

RDEPEND="
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep kcmutils)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep knewstuff)
	$(add_frameworks_dep kwidgetsaddons)
	dev-libs/glib:2
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	x11-libs/gtk+:2
	x11-libs/gtk+:3
"
DEPEND="${RDEPEND}"

pkg_postinst() {
	kde5_pkg_postinst
	einfo
	elog "If you notice missing icons in your GTK applications, you may have to install"
	elog "the corresponding themes for GTK. A good guess would be x11-themes/oxygen-gtk"
	elog "for example."
	einfo
}
