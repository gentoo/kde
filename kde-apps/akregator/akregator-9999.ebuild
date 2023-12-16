# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="optional"
ECM_TEST="forceoptional"
PVCUT=$(ver_cut 1-3)
KFMIN=5.245.0
QTMIN=6.6.0
inherit ecm gear.kde.org

DESCRIPTION="News feed aggregator"
HOMEPAGE="https://apps.kde.org/akregator/"

LICENSE="GPL-2+ handbook? ( FDL-1.2+ )"
SLOT="6"
KEYWORDS=""
IUSE="speech telemetry"

RDEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,network,widgets,xml]
	>=dev-qt/qtwebengine-${QTMIN}:6
	>=kde-apps/grantleetheme-${PVCUT}:6
	>=kde-apps/kontactinterface-${PVCUT}:6
	>=kde-apps/kpimtextedit-${PVCUT}:6[speech=]
	>=kde-apps/libkdepim-${PVCUT}:6
	>=kde-apps/messagelib-${PVCUT}:6
	>=kde-apps/pimcommon-${PVCUT}:6
	>=kde-frameworks/kcmutils-${KFMIN}:6
	>=kde-frameworks/kcodecs-${KFMIN}:6
	>=kde-frameworks/kcompletion-${KFMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kconfigwidgets-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kcrash-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kio-${KFMIN}:6
	>=kde-frameworks/kjobwidgets-${KFMIN}:6
	>=kde-frameworks/knotifications-${KFMIN}:6
	>=kde-frameworks/knotifyconfig-${KFMIN}:6
	>=kde-frameworks/kparts-${KFMIN}:6
	>=kde-frameworks/ktextwidgets-${KFMIN}:6
	>=kde-frameworks/kwidgetsaddons-${KFMIN}:6
	>=kde-frameworks/kxmlgui-${KFMIN}:6
	>=kde-frameworks/syndication-${KFMIN}:6
	telemetry? ( >=kde-frameworks/syndication-${KFMIN}:6 )
"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake_use_find_package telemetry KF6UserFeedback)
	)

	ecm_src_configure
}
