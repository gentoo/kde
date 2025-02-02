# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="forceoptional"
KDE_ORG_CATEGORY="pim"
PVCUT=$(ver_cut 1-3)
KFMIN=6.9.0
QTMIN=6.7.2
inherit ecm gear.kde.org optfeature xdg

DESCRIPTION="Digital travel assistant with a priority on protecting your privacy"
HOMEPAGE="https://apps.kde.org/itinerary/
https://www.volkerkrause.eu/2018/08/19/kde-itinerary-introduction.html"

LICENSE="LGPL-2+"
SLOT="6"
KEYWORDS=""
IUSE="matrix"

DEPEND="
	>=dev-libs/kirigami-addons-0.9:6
	>=dev-libs/kosmindoormap-${PVCUT}:6
	>=dev-libs/kpublictransport-${PVCUT}:6
	>=dev-libs/qtkeychain-0.14.2:=[qt6(+)]
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,network,widgets]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=dev-qt/qtlocation-${QTMIN}:6
	>=dev-qt/qtpositioning-${QTMIN}:6[qml]
	>=kde-apps/kitinerary-${PVCUT}:6
	>=kde-apps/kpkpass-${PVCUT}:6
	>=kde-frameworks/kcalendarcore-${KFMIN}:6
	>=kde-frameworks/kcontacts-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kdbusaddons-${KFMIN}:6
	>=kde-frameworks/kfilemetadata-${KFMIN}:6
	>=kde-frameworks/kholidays-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kitemmodels-${KFMIN}:6
	>=kde-frameworks/knotifications-${KFMIN}:6
	>=kde-frameworks/kunitconversion-${KFMIN}:6
	>=kde-frameworks/kwindowsystem-${KFMIN}:6
	sys-libs/zlib
	matrix? ( >=net-libs/libquotient-0.8.1.2-r1:=[qt6(+)] )
"
RDEPEND="${DEPEND}
	>=dev-qt/qtmultimedia-${QTMIN}:6[qml]
	>=kde-frameworks/kirigami-${KFMIN}:6
	>=kde-frameworks/prison-${KFMIN}:6[qml]
"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_DISABLE_FIND_PACKAGE_SeleniumWebDriverATSPI=ON # not packaged
		$(cmake_use_find_package matrix QuotientQt6)
	)
	ecm_src_configure
}

pkg_postinst() {
	if [[ -z "${REPLACING_VERSIONS}" ]]; then
		optfeature "screen brightness control to aid barcode scanning" "kde-frameworks/solid:6"
	fi
	xdg_pkg_postinst
}
