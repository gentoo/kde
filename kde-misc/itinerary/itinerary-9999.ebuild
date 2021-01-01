# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECM_TEST="forceoptional"
PVCUT=$(ver_cut 1-3)
KFMIN=5.74.0
QTMIN=5.15.1
inherit ecm kde.org optfeature

DESCRIPTION="Digital travel assistant with a priority on protecting your privacy"
HOMEPAGE="https://apps.kde.org/en/itinerary
https://www.volkerkrause.eu/2018/08/19/kde-itinerary-introduction.html"

LICENSE="LGPL-2+"
SLOT="5"
KEYWORDS=""
IUSE="+networkmanager"

DEPEND="
	>=dev-libs/kosmindoormap-${PVCUT}:5
	>=dev-qt/qtdeclarative-${QTMIN}:5
	>=dev-qt/qtdbus-${QTMIN}:5
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtnetwork-${QTMIN}:5
	>=dev-qt/qtlocation-${QTMIN}:5
	>=dev-qt/qtpositioning-${QTMIN}:5
	>=dev-qt/qtquickcontrols2-${QTMIN}:5
	>=dev-qt/qtwidgets-${QTMIN}:5
	>=kde-apps/kitinerary-${PVCUT}:5
	>=kde-apps/kpkpass-${PVCUT}:5
	>=kde-frameworks/kcontacts-${KFMIN}:5
	>=kde-frameworks/kcoreaddons-${KFMIN}:5
	>=kde-frameworks/kdbusaddons-${KFMIN}:5
	>=kde-frameworks/kholidays-${KFMIN}:5
	>=kde-frameworks/ki18n-${KFMIN}:5
	>=kde-frameworks/knotifications-${KFMIN}:5
	>=kde-misc/kpublictransport-${PVCUT}:5
	sys-libs/zlib
	networkmanager? ( >=kde-frameworks/networkmanager-qt-${KFMIN}:5 )
"
RDEPEND="${DEPEND}
	>=kde-frameworks/kirigami-${KFMIN}:5
	>=kde-frameworks/prison-${KFMIN}:5
"

src_configure() {
	local mycmakeargs=(
		$(cmake_use_find_package networkmanager KF5NetworkManagerQt)
	)
	ecm_src_configure
}

pkg_postinst() {
	if [[ -z "${REPLACING_VERSIONS}" ]]; then
		elog "Optional dependencies:"
		optfeature "screen brightness control to aid barcode scanning" "kde-frameworks/solid:5"
	fi
	ecm_pkg_postinst
}
