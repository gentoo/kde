# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="forceoptional"
KFMIN=5.245.0
PVCUT=$(ver_cut 1-3)
QTMIN=6.6.0
inherit ecm plasma.kde.org

DESCRIPTION="Power management for KDE Plasma Shell"
HOMEPAGE="https://invent.kde.org/plasma/powerdevil"

LICENSE="GPL-2" # TODO: CHECK
SLOT="6"
KEYWORDS=""
IUSE="brightness-control caps +wireless"

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,widgets]
	>=kde-frameworks/kauth-${KFMIN}:6[policykit]
	>=kde-frameworks/kcompletion-${KFMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kconfigwidgets-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kcrash-${KFMIN}:6
	>=kde-frameworks/kdbusaddons-${KFMIN}:6
	>=kde-frameworks/kglobalaccel-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kidletime-${KFMIN}:6
	>=kde-frameworks/kio-${KFMIN}:6
	>=kde-frameworks/kirigami-${KFMIN}:6
	>=kde-frameworks/knotifications-${KFMIN}:6
	>=kde-frameworks/knotifyconfig-${KFMIN}:6
	>=kde-frameworks/kservice-${KFMIN}:6
	>=kde-frameworks/kwidgetsaddons-${KFMIN}:6
	>=kde-frameworks/kxmlgui-${KFMIN}:6
	>=kde-frameworks/solid-${KFMIN}:6
	>=kde-plasma/libkscreen-${PVCUT}:6
	>=kde-plasma/libkworkspace-${PVCUT}:6
	>=kde-plasma/plasma-activities-${PVCUT}:6
	virtual/libudev:=
	x11-libs/libxcb
	brightness-control? ( app-misc/ddcutil:= )
	caps? ( sys-libs/libcap )
	wireless? (
		>=kde-frameworks/bluez-qt-${KFMIN}:6
		>=kde-frameworks/networkmanager-qt-${KFMIN}:6
	)
"
RDEPEND="${DEPEND}
	>=kde-plasma/kde-cli-tools-${PVCUT}:*
	sys-power/power-profiles-daemon
	>=sys-power/upower-0.9.23
"
BDEPEND=">=kde-frameworks/kcmutils-${KFMIN}:6"

src_configure() {
	local mycmakeargs=(
		-DHAVE_DDCUTIL=$(usex brightness-control)
		$(cmake_use_find_package caps Libcap)
		$(cmake_use_find_package wireless KF5BluezQt)
		$(cmake_use_find_package wireless KF5NetworkManagerQt)
	)

	ecm_src_configure
}
