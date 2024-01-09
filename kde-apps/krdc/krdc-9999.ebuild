# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="optional"
KFMIN=5.248.0
QTMIN=6.6.0
inherit ecm gear.kde.org

DESCRIPTION="Remote desktop connection (RDP and VNC) client"
HOMEPAGE="https://apps.kde.org/krdc/"

LICENSE="GPL-2" # TODO: CHECK
SLOT="6"
KEYWORDS=""
IUSE="activities +rdp +vnc"

#nx? ( >=net-misc/nxcl-0.9-r1 ) disabled upstream, last checked 2016-01-24
DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[gui,widgets,xml]
	>=kde-frameworks/kbookmarks-${KFMIN}:6
	>=kde-frameworks/kcmutils-${KFMIN}:6
	>=kde-frameworks/kcompletion-${KFMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kconfigwidgets-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kdnssd-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kiconthemes-${KFMIN}:6
	>=kde-frameworks/knotifications-${KFMIN}:6
	>=kde-frameworks/knotifyconfig-${KFMIN}:6
	>=kde-frameworks/kservice-${KFMIN}:6
	>=kde-frameworks/kstatusnotifieritem-${KFMIN}:6
	>=kde-frameworks/kwallet-${KFMIN}:6
	>=kde-frameworks/kwidgetsaddons-${KFMIN}:6
	>=kde-frameworks/kwindowsystem-${KFMIN}:6
	>=kde-frameworks/kxmlgui-${KFMIN}:6
	activities? ( kde-plasma/plasma-activities:6 )
	rdp? ( >=net-misc/freerdp-2.1.0:= )
	vnc? (
		net-libs/libssh:=
		>=net-libs/libvncserver-0.9
	)
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake_use_find_package activities PlasmaActivities)
		-DWITH_RDP=$(usex rdp)
		-DWITH_VNC=$(usex vnc)
	)

	ecm_src_configure
}
