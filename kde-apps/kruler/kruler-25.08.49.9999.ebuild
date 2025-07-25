# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="forceoptional"
KFMIN=6.16.0
QTMIN=6.9.1
inherit ecm gear.kde.org xdg

DESCRIPTION="Screen ruler for Plasma"
HOMEPAGE="https://apps.kde.org/kruler/"

LICENSE="GPL-2+ handbook? ( FDL-1.2 )"
SLOT="6"
KEYWORDS=""
IUSE="X"

# slot op: Uses Qt6::GuiPrivate for qtx11extras_p.h
DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[gui,widgets]
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kconfigwidgets-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kcrash-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/knotifications-${KFMIN}:6
	>=kde-frameworks/kstatusnotifieritem-${KFMIN}:6
	>=kde-frameworks/kwidgetsaddons-${KFMIN}:6
	>=kde-frameworks/kwindowsystem-${KFMIN}:6[X?]
	>=kde-frameworks/kxmlgui-${KFMIN}:6
	X? (
		>=dev-qt/qtbase-${QTMIN}:6=[X]
		x11-libs/libxcb
	)
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DWITHOUT_X11=$(usex !X)
	)

	ecm_src_configure
}
