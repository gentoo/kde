# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="optional"
ECM_TEST="true"
KFMIN=5.245.0
QTMIN=6.6.0
inherit ecm gear.kde.org

DESCRIPTION="Client for Matrix, the decentralized communication protocol"
HOMEPAGE="https://apps.kde.org/neochat/"

LICENSE="GPL-3+ handbook? ( CC-BY-SA-4.0 )"
SLOT="0"
KEYWORDS=""

DEPEND="
	app-text/cmark:=
	dev-libs/kirigami-addons:6
	dev-libs/qcoro
	>=dev-libs/qtkeychain-0.14.1-r1:=[qt6]
	>=dev-qt/qtbase-${QTMIN}:6[gui,network,widgets]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=dev-qt/qtmultimedia-${QTMIN}:6[gstreamer]
	>=dev-qt/qtsvg-${QTMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kconfigwidgets-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kdbusaddons-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kio-${KFMIN}:6
	>=kde-frameworks/kirigami-${KFMIN}:6
	>=kde-frameworks/kitemmodels-${KFMIN}:6[qml]
	>=kde-frameworks/knotifications-${KFMIN}:6
	>=kde-frameworks/kwindowsystem-${KFMIN}:6
	>=kde-frameworks/qqc2-desktop-style-${KFMIN}:6
	>=kde-frameworks/sonnet-${KFMIN}:6[qml]
	media-libs/kquickimageeditor:6
	>=net-libs/libquotient-0.8.1.2-r1:=[qt6]
"
RDEPEND="${DEPEND}
	>=dev-qt/qt5compat-${QTMIN}:6[qml]
	>=dev-qt/qtlocation-${QTMIN}:6
	>=dev-qt/qtmultimedia-${QTMIN}:6[qml]
	>=dev-qt/qtpositioning-${QTMIN}:6[qml]
	>=kde-frameworks/kquickcharts-${KFMIN}:6
	>=kde-frameworks/purpose-${KFMIN}:6
"
BDEPEND="virtual/pkgconfig"
