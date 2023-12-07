# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=5.245.0
PVCUT=$(ver_cut 1-3)
QTMIN=6.6.0
inherit ecm plasma.kde.org

DESCRIPTION="A friendly onboarding wizard for Plasma"

LICENSE="GPL-2+"
SLOT="6"
KEYWORDS=""
IUSE="discover telemetry" # +kaccounts

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[gui,network,widgets]
	>=dev-qt/qtdeclarative-${QTMIN}:6[widgets]
	>=dev-qt/qtsvg-${QTMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kconfigwidgets-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kdbusaddons-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kio-${KFMIN}:6
	>=kde-frameworks/kirigami-${KFMIN}:6
	>=kde-frameworks/knewstuff-${KFMIN}:6
	>=kde-frameworks/knotifications-${KFMIN}:6
	>=kde-frameworks/kservice-${KFMIN}:6
	>=kde-frameworks/kwindowsystem-${KFMIN}:6
	>=kde-plasma/libplasma-${PVCUT}:6
	telemetry? ( >=kde-frameworks/kuserfeedback-${KFMIN}:6 )
"
# 	kaccounts? ( kde-apps/kaccounts-integration:6 )
RDEPEND="${DEPEND}
	discover? ( kde-plasma/discover:6 )
"

src_prepare() {
	ecm_src_prepare

	if ! use discover; then
		sed -e "s:pageStack.push(discover);:// & disabled by IUSE=discover:" \
			-i src/contents/ui/Main.qml || die
	fi
}

src_configure() {
	local mycmakeargs=(
# 		$(cmake_use_find_package kaccounts KAccounts)
		$(cmake_use_find_package telemetry KF6UserFeedback)
	)
	ecm_src_configure
}
