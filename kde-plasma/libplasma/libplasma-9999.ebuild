# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_QTHELP="false" # TODO: Port to ECMGenerateQDoc
ECM_TEST="true"
KFMIN=9999
QTMIN=6.10.1
inherit ecm plasma.kde.org

DESCRIPTION="Plasma library and runtime components based upon KF6 and Qt6"

LICENSE="LGPL-2+"
SLOT="6/7"
KEYWORDS=""
IUSE="activities"

RESTRICT="test"

# dev-qt/qtbase slot op: includes qpa/qplatformwindow_p.h, qpa/qplatformwindow.h
COMMON_DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6=[dbus,gui,opengl,widgets]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=dev-qt/qtsvg-${QTMIN}:6
	>=dev-libs/wayland-1.15.0
	>=kde-frameworks/kcolorscheme-${KFMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kglobalaccel-${KFMIN}:6
	>=kde-frameworks/kguiaddons-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kiconthemes-${KFMIN}:6
	>=kde-frameworks/kio-${KFMIN}:6
	>=kde-frameworks/kirigami-${KFMIN}:6
	>=kde-frameworks/knotifications-${KFMIN}:6
	>=kde-frameworks/kpackage-${KFMIN}:6
	>=kde-frameworks/ksvg-${KFMIN}:6
	>=kde-frameworks/kwidgetsaddons-${KFMIN}:6
	>=kde-frameworks/kwindowsystem-${KFMIN}:6
	activities? ( =kde-plasma/plasma-activities-${KDE_CATV}*:6= )
"
DEPEND="${COMMON_DEPEND}
	>=dev-libs/plasma-wayland-protocols-1.19.0
	>=dev-libs/wayland-protocols-1.46
	test? ( >=kde-frameworks/karchive-${KFMIN}:6 )
"
RDEPEND="${COMMON_DEPEND}
	!${CATEGORY}/${PN}:5[-kf6compat(-)]
	>=dev-qt/qt5compat-${QTMIN}:6[qml]
	>=kde-frameworks/kconfig-${KFMIN}:6[qml]
"
BDEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[wayland]
	>=dev-util/wayland-scanner-1.19.0
"

src_configure() {
	local mycmakeargs=(
		-DWITHOUT_X11=ON # until upstream MR 1513 is merged
		-DENABLE_ACTIVITIES=$(usex activities)
	)

	ecm_src_configure
}
