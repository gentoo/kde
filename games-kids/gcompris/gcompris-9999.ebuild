# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_HANDBOOK="optional"
KDE_TEST="true"
inherit kde5

DESCRIPTION="Full featured educational application for children from 2 to 10"
HOMEPAGE="https://gcompris.net/"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS=""
IUSE="kiosk"

RDEPEND="
	$(add_qt_dep qtdeclarative)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtnetwork)
	$(add_qt_dep qtsensors)
	$(add_qt_dep qtsvg)
"
DEPEND="${RDEPEND}
	$(add_qt_dep linguist-tools)
	$(add_qt_dep qtmultimedia)
	$(add_qt_dep qtxml)
	$(add_qt_dep qtxmlpatterns)
"

src_configure() {
	local mycmakeargs=(
		-DQML_BOX2D_MODULE=disabled
		-DWITH_KIOSK_MODE=$(usex kiosk)
	)
	kde5_src_configure
}
