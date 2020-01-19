# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECM_HANDBOOK="optional"
ECM_TEST="true"
KDE_ORG_NAME="${PN}-kde"
KDE_SELINUX_MODULE="${PN}"
KFMIN=5.64.0
QTMIN=5.12.3
inherit ecm kde.org

if [[ ${KDE_BUILD_TYPE} = release ]]; then
	SRC_URI="mirror://kde/stable/${PN}/${PV}/src/${KDE_ORG_NAME}-${PV}.tar.xz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Adds communication between KDE Plasma and your smartphone"
HOMEPAGE="https://kde.org/ https://community.kde.org/KDEConnect"

LICENSE="GPL-2+"
SLOT="5"
IUSE="app bluetooth mousepad phonon pulseaudio sms wayland"

DEPEND="
	>=app-crypt/qca-2.1.0:2[qt5(+),ssl]
	>=dev-qt/qtdbus-${QTMIN}:5
	>=dev-qt/qtdeclarative-${QTMIN}:5
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtnetwork-${QTMIN}:5
	>=dev-qt/qtwidgets-${QTMIN}:5
	>=dev-qt/qtx11extras-${QTMIN}:5
	>=kde-frameworks/kcmutils-${KFMIN}:5
	>=kde-frameworks/kconfig-${KFMIN}:5
	>=kde-frameworks/kconfigwidgets-${KFMIN}:5
	>=kde-frameworks/kcoreaddons-${KFMIN}:5
	>=kde-frameworks/kdbusaddons-${KFMIN}:5
	>=kde-frameworks/ki18n-${KFMIN}:5
	>=kde-frameworks/kiconthemes-${KFMIN}:5
	>=kde-frameworks/kio-${KFMIN}:5
	>=kde-frameworks/knotifications-${KFMIN}:5
	>=kde-frameworks/kservice-${KFMIN}:5
	>=kde-frameworks/kwidgetsaddons-${KFMIN}:5
	app? ( >=kde-frameworks/kdeclarative-${KFMIN}:5 )
	bluetooth? ( >=dev-qt/qtbluetooth-${QTMIN}:5 )
	mousepad? (
		x11-libs/libfakekey
		x11-libs/libX11
		x11-libs/libXtst
	)
	phonon? ( media-libs/phonon )
	pulseaudio? ( media-libs/pulseaudio-qt )
	sms? ( >=kde-frameworks/kpeople-${KFMIN}:5 )
	wayland? ( >=kde-frameworks/kwayland-${KFMIN}:5 )
"
RDEPEND="${DEPEND}
	>=dev-qt/qtquickcontrols2-${QTMIN}:5
	net-fs/sshfs
	app? ( >=kde-frameworks/kirigami-${KFMIN}:5 )
	sms? (
		dev-libs/kpeoplevcard
		>=kde-frameworks/kirigami-${KFMIN}:5
	)
"

RESTRICT+=" test"

src_configure() {
	local mycmakeargs=(
		-DEXPERIMENTALAPP_ENABLED=$(usex app)
		-DBLUETOOTH_ENABLED=$(usex bluetooth)
		$(cmake_use_find_package mousepad LibFakeKey)
		$(cmake_use_find_package phonon Phonon4Qt5)
		$(cmake_use_find_package pulseaudio KF5PulseAudioQt)
		-DSMSAPP_ENABLED=$(usex sms)
		$(cmake_use_find_package wayland KF5Wayland)
	)

	ecm_src_configure
}

pkg_postinst(){
	ecm_pkg_postinst

	elog "The Android .apk file is available via"
	elog "https://play.google.com/store/apps/details?id=org.kde.kdeconnect_tp"
	elog "or via"
	elog "https://f-droid.org/repository/browse/?fdid=org.kde.kdeconnect_tp"
}
