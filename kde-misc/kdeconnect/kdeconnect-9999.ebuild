# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="optional"
ECM_TEST="true"
KDE_ORG_NAME="${PN}-kde"
KDE_SELINUX_MODULE="${PN}"
KFMIN=5.245.0
QTMIN=6.6.0
inherit ecm gear.kde.org

DESCRIPTION="Adds communication between KDE Plasma and your smartphone"
HOMEPAGE="https://kdeconnect.kde.org/ https://apps.kde.org/kdeconnect/"

LICENSE="GPL-2+"
SLOT="6"
KEYWORDS=""
IUSE="bluetooth pulseaudio telephony X"

RESTRICT="test"

COMMON_DEPEND="
	>=app-crypt/qca-2.3.0:2[qt5(+),ssl]
	dev-libs/glib:2
	>=dev-libs/wayland-1.15.0
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=dev-qt/qtmultimedia-${QTMIN}:6
	>=dev-qt/qtwayland-${QTMIN}:6
	>=kde-frameworks/kcmutils-${KFMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kconfigwidgets-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kdbusaddons-${KFMIN}:6
	>=kde-frameworks/kguiaddons-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kiconthemes-${KFMIN}:6
	>=kde-frameworks/kio-${KFMIN}:6
	>=kde-frameworks/kirigami-${KFMIN}:6
	>=kde-frameworks/knotifications-${KFMIN}:6
	>=kde-frameworks/kpeople-${KFMIN}:6
	>=kde-frameworks/kservice-${KFMIN}:6
	>=kde-frameworks/kwidgetsaddons-${KFMIN}:6
	>=kde-frameworks/kwindowsystem-${KFMIN}:6
	>=kde-frameworks/qqc2-desktop-style-${KFMIN}:6
	>=kde-frameworks/solid-${KFMIN}:6
	>=kde-plasma/libplasma-${KFMIN}:6
	x11-libs/libxkbcommon
	pulseaudio? ( media-libs/pulseaudio-qt6:= )
	telephony? ( >=kde-frameworks/modemmanager-qt-${KFMIN}:6 )
	X? (
		x11-libs/libfakekey
		x11-libs/libX11
		x11-libs/libXtst
	)
"
DEPEND="${COMMON_DEPEND}
	!!kde-misc/kdeconnect:5
	dev-libs/wayland-protocols
"
RDEPEND="${COMMON_DEPEND}
	dev-libs/kirigami-addons:6
	dev-libs/kpeoplevcard
	>=dev-qt/qtmultimedia-${QTMIN}:6[qml]
	>=kde-frameworks/kdeclarative-${KFMIN}:6
	net-fs/sshfs
"
BDEPEND="
	dev-util/wayland-scanner
	virtual/pkgconfig
"

src_configure() {
	local mycmakeargs=(
		-DBLUETOOTH_ENABLED=$(usex bluetooth)
		-DWITH_X11=$(usex X)
		$(cmake_use_find_package pulseaudio KF6PulseAudioQt)
		$(cmake_use_find_package telephony KF6ModemManagerQt)
		$(cmake_use_find_package X LibFakeKey)
	)
	ecm_src_configure
}

pkg_postinst() {
	ecm_pkg_postinst

	elog "The Android .apk file is available via"
	elog "https://play.google.com/store/apps/details?id=org.kde.kdeconnect_tp"
	elog "or via"
	elog "https://f-droid.org/packages/org.kde.kdeconnect_tp/"
}
