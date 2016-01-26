# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGIT_BRANCH="port-to-kf5"
inherit kde5 eutils

DESCRIPTION="The japanese warehouse keeper game"
HOMEPAGE="https://projects.kde.org/projects/playground/games/ksokoban"

LICENSE="GPL-2"
KEYWORDS=""

DEPEND="
	$(add_frameworks_dep kactivities)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
"
RDEPEND="${DEPEND}
	!games-puzzle/ksokoban:0
"

src_prepare() {
	sed -i \
		-e "/Exec/ s/%i.*//" \
		"data/${PN}.desktop" || die "sed for desktop file failed"

	kde5_src_prepare
}

# source lacks install target
src_install() {
	dobin "${BUILD_DIR}"/ksokoban
	dodoc AUTHORS NEWS TODO
	domenu "data/${PN}.desktop"
	for i in 16 22 32 48 64 128; do
		doicon -s "${i}" "data/hi${i}-app-${PN}.png"
	done
}
