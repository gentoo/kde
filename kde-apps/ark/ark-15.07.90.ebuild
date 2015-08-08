# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_HANDBOOK=true
KDE_TEST=true
inherit kde5

DESCRIPTION="KDE Archiving tool"
HOMEPAGE="http://www.kde.org/applications/utilities/ark
http://utils.kde.org/projects/ark"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcrash)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kdoctools)
	$(add_frameworks_dep khtml)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep khtml)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep kpty)
	$(add_frameworks_dep kwidgetsaddons)
	>=app-arch/libarchive-3.0.0
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	sys-libs/zlib
"
DEPEND="${RDEPEND}
	sys-devel/gettext"

pkg_postinst() {
	kde5_pkg_postinst

	if ! has_version app-arch/rar ; then
		elog "For creating rar archives, install app-arch/rar"
	fi
}
