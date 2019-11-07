# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECM_HANDBOOK="optional"
ECM_TEST="true"
QT5MIN=5.12.3
inherit ecm kde.org

DESCRIPTION="Full featured educational application for children from 2 to 10"
HOMEPAGE="https://gcompris.net/"

if [[ ${KDE_BUILD_TYPE} = release ]]; then
	SRC_URI="https://gcompris.net/download/qt/src/beta/${PN}-qt-${PV/_/-}.tar.xz"
	KEYWORDS=""
	S="${WORKDIR}/${PN}-qt-${PV/_beta/}"
fi

LICENSE="GPL-3+"
SLOT="0"
IUSE="kiosk"

BDEPEND="
	>=dev-qt/linguist-tools-${QT5MIN}:5
	test? (
		dev-util/cppcheck
		sys-devel/clang
	)
"
RDEPEND="
	>=dev-qt/qtdeclarative-${QT5MIN}:5
	>=dev-qt/qtgui-${QT5MIN}:5
	>=dev-qt/qtnetwork-${QT5MIN}:5
	>=dev-qt/qtsensors-${QT5MIN}:5
	>=dev-qt/qtsvg-${QT5MIN}:5
"
DEPEND="${RDEPEND}
	>=dev-qt/qtmultimedia-${QT5MIN}:5
	>=dev-qt/qtxml-${QT5MIN}:5
	>=dev-qt/qtxmlpatterns-${QT5MIN}:5
"

src_configure() {
	local mycmakeargs=(
		-DQML_BOX2D_MODULE=disabled
		-DWITH_KIOSK_MODE=$(usex kiosk)
	)
	ecm_src_configure
}
