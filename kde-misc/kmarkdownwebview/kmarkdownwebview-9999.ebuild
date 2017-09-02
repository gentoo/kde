# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

QT_MINIMAL="5.7.1"
inherit kde5

DESCRIPTION="KPart for rendering Markdown content "
HOMEPAGE="http://www.krename.net/"

LICENSE="GPL-2"
KEYWORDS=""
IUSE="webkit"

DEPEND="
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kparts)
	$(add_frameworks_dep kxmlgui)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtwidgets)
	webkit? ( $(add_qt_dep qtwebkit) )
	!webkit? (
		$(add_qt_dep qtwebchannel)
		$(add_qt_dep qtwebengine 'widgets')
	)
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DUSE_QTWEBKIT=$(usex webkit)
	)

	kde5_src_configure
}
