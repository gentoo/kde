# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="true"
ECM_HANDBOOK="optional"
KFMIN=6.5.0
QTMIN=6.7.2
inherit ecm kde.org

DESCRIPTION="Multiple information organizer - a DropDrawers clone"
HOMEPAGE="https://userbase.kde.org/BasKet https://invent.kde.org/utilities/basket"

if [[ ${KDE_BUILD_TYPE} = release ]]; then
	SRC_URI="https://github.com/${PN}-notepads/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="crypt git"

COMMON_DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,network,widgets,xml]
	>=kde-frameworks/karchive-${KFMIN}:6
	>=kde-frameworks/kcmutils-${KFMIN}:6
	>=kde-frameworks/kcodecs-${KFMIN}:6
	>=kde-frameworks/kcompletion-${KFMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kconfigwidgets-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kcrash-${KFMIN}:6
	>=kde-frameworks/kdbusaddons-${KFMIN}:6
	>=kde-frameworks/kfilemetadata-${KFMIN}:6
	>=kde-frameworks/kglobalaccel-${KFMIN}:6
	>=kde-frameworks/kguiaddons-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kiconthemes-${KFMIN}:6
	>=kde-frameworks/kio-${KFMIN}:6
	>=kde-frameworks/knotifications-${KFMIN}:6
	>=kde-frameworks/kparts-${KFMIN}:6
	>=kde-frameworks/kservice-${KFMIN}:6
	>=kde-frameworks/ktextwidgets-${KFMIN}:6
	>=kde-frameworks/kwidgetsaddons-${KFMIN}:6
	>=kde-frameworks/kwindowsystem-${KFMIN}:6
	>=kde-frameworks/kxmlgui-${KFMIN}:6
	>=media-libs/phonon-4.12.0[qt6(+)]
	x11-libs/libX11
	crypt? ( app-crypt/gpgme:= )
	git? ( dev-libs/libgit2:= )
"
DEPEND="${COMMON_DEPEND}
	>=dev-qt/qtbase-${QTMIN}:6[concurrent]
"
RDEPEND="${COMMON_DEPEND}
	!${CATEGORY}/${PN}:5
"
BDEPEND="git? ( virtual/pkgconfig )"

src_configure() {
	local mycmakeargs=(
		-DENABLE_GPG=$(usex crypt)
		$(cmake_use_find_package git Libgit2)
	)
	ecm_src_configure
}
