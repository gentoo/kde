# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_BRANCH="plasma"
KDE_HANDBOOK="true"
inherit kde5

DESCRIPTION="An advanced twin-panel (commander-style) file-manager with many extras"
HOMEPAGE="http://www.krusader.org/"

LICENSE="GPL-2"
KEYWORDS=""
IUSE="xattr"

CDEPEND="
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep kbookmarks)
	$(add_frameworks_dep kcodecs)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kitemviews)
	$(add_frameworks_dep kjobwidgets)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep kparts)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwallet)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep solid)
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtprintsupport:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	sys-libs/zlib
	xattr? ( sys-apps/attr )
"
DEPEND="${CDEPEND}
	sys-devel/gettext
"
RDEPEND="${CDEPEND}
	!kde-misc/krusader:4
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package xattr ACL)
	)

	kde5_src_configure
}
