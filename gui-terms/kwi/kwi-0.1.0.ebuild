# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="true"
KDE_ORG_CATEGORY="utilities"
KDE_VERIFY_SIG=1
KFMIN=6.29.0
QTMIN=6.11.2
inherit ecm kde.org

if [[ ${KDE_BUILD_TYPE} = release ]]; then
	SRC_URI="mirror://kde/stable/${PN}/${PV}/${P}.tar.xz"
	if [[ -n ${KDE_VERIFY_SIG} ]]; then
		SRC_URI+=" verify-sig? ( mirror://kde/stable/${PN}/${PV}/${P}.tar.xz.sig )"
	fi
	KEYWORDS="~amd64"
fi

DESCRIPTION="Modern and fast terminal for KDE Plasma and other desktops"
HOMEPAGE="https://invent.kde.org/utilities/kwi"

LICENSE="
	|| ( GPL-2 GPL-3 ) GPL-2+
	|| ( LGPL-2.1 LGPL-3 ) LGPL-2+
	BSD-2 CC-BY-SA-4.0 CC0-1.0
"
SLOT="0"
IUSE="+app +kpart"
REQUIRED_USE="|| ( app kpart )"

# qtbase:= Qt6GuiPrivate
DEPEND="
	>=dev-libs/kirigami-addons-1.11:6
	>=dev-libs/libghostty-vt-1.0.1:=
	>=dev-qt/qtbase-${QTMIN}:6=[concurrent,dbus,gui,network,widgets]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=dev-qt/qtsvg-${QTMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kcolorscheme-${KFMIN}:6
	>=kde-frameworks/kconfigwidgets-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kguiaddons-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kio-${KFMIN}:6
	>=kde-frameworks/kirigami-${KFMIN}:6
	>=kde-frameworks/knotifications-${KFMIN}:6
	>=kde-frameworks/kpty-${KFMIN}:6
	>=kde-frameworks/kwindowsystem-${KFMIN}:6
	app? (
		>=dev-libs/kirigami-app-components-1.1:6
		>=kde-frameworks/kdbusaddons-${KFMIN}:6
	)
	kpart? (
		>=dev-qt/qtdeclarative-${QTMIN}:6[widgets]
		>=kde-frameworks/kiconthemes-${KFMIN}:6
		>=kde-frameworks/kparts-${KFMIN}:6
		>=kde-frameworks/kwidgetsaddons-${KFMIN}:6
		>=kde-frameworks/kxmlgui-${KFMIN}:6
	)
"
# QML runtime dependencies, see ecm_find_qmlmodule in CMakeLists.txt
RDEPEND="${DEPEND}
	>=kde-frameworks/qqc2-desktop-style-${KFMIN}:6
	app? ( >=kde-frameworks/kitemmodels-${KFMIN}:6 )
"
BDEPEND="
	>=dev-qt/qtshadertools-${QTMIN}:6
	virtual/pkgconfig
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_APP=$(usex app)
		-DBUILD_KPART=$(usex kpart)
	)
	ecm_src_configure
}
