# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="true"
ECM_HANDBOOK="forceoptional"
KFMIN=5.82.0
QTMIN=5.15.5
VIRTUALX_REQUIRED="test"
inherit ecm kde.org

DESCRIPTION="Multiple information organizer - a DropDrawers clone"
HOMEPAGE="https://userbase.kde.org/BasKet https://invent.kde.org/utilities/basket"

if [[ ${KDE_BUILD_TYPE} = release ]]; then
	SRC_URI="https://github.com/${PN}-notepads/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

LICENSE="GPL-2"
SLOT="5"
IUSE="crypt git"

BDEPEND="git? ( virtual/pkgconfig )"
RDEPEND="
	>=dev-qt/qtdbus-${QTMIN}:5
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtnetwork-${QTMIN}:5
	>=dev-qt/qtwidgets-${QTMIN}:5
	>=dev-qt/qtxml-${QTMIN}:5
	>=kde-frameworks/karchive-${KFMIN}:5
	>=kde-frameworks/kcmutils-${KFMIN}:5
	>=kde-frameworks/kcodecs-${KFMIN}:5
	>=kde-frameworks/kcompletion-${KFMIN}:5
	>=kde-frameworks/kconfig-${KFMIN}:5
	>=kde-frameworks/kconfigwidgets-${KFMIN}:5
	>=kde-frameworks/kcoreaddons-${KFMIN}:5
	>=kde-frameworks/kcrash-${KFMIN}:5
	>=kde-frameworks/kdbusaddons-${KFMIN}:5
	>=kde-frameworks/kfilemetadata-${KFMIN}:5
	>=kde-frameworks/kglobalaccel-${KFMIN}:5
	>=kde-frameworks/kguiaddons-${KFMIN}:5
	>=kde-frameworks/ki18n-${KFMIN}:5
	>=kde-frameworks/kiconthemes-${KFMIN}:5
	>=kde-frameworks/kio-${KFMIN}:5
	>=kde-frameworks/knotifications-${KFMIN}:5
	>=kde-frameworks/kparts-${KFMIN}:5
	>=kde-frameworks/kservice-${KFMIN}:5
	>=kde-frameworks/ktextwidgets-${KFMIN}:5
	>=kde-frameworks/kwidgetsaddons-${KFMIN}:5
	>=kde-frameworks/kwindowsystem-${KFMIN}:5
	>=kde-frameworks/kxmlgui-${KFMIN}:5
	>=media-libs/phonon-4.11.0
	x11-libs/libX11
	crypt? ( app-crypt/gpgme:= )
	git? ( dev-libs/libgit2:= )
"
DEPEND="${RDEPEND}
	>=dev-qt/qtconcurrent-${QTMIN}:5
"

src_configure() {
	local mycmakeargs=(
		-DENABLE_GPG=$(usex crypt)
		$(cmake_use_find_package git Libgit2)
	)
	ecm_src_configure
}
