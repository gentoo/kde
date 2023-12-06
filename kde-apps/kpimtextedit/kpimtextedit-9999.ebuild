# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_DESIGNERPLUGIN="true"
ECM_QTHELP="true"
ECM_TEST="true"
KFMIN=5.245.0
QTMIN=6.6.0
inherit ecm gear.kde.org

DESCRIPTION="Extended text editor for PIM applications"

LICENSE="LGPL-2.1+"
SLOT="6"
KEYWORDS=""
IUSE="speech"

RESTRICT="test"

RDEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[gui,widgets]
	>=kde-frameworks/kcodecs-${KFMIN}:6
	>=kde-frameworks/kcompletion-${KFMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kiconthemes-${KFMIN}:6
	>=kde-frameworks/kio-${KFMIN}:6
	>=kde-frameworks/kwidgetsaddons-${KFMIN}:6
	>=kde-frameworks/kxmlgui-${KFMIN}:6
	>=kde-frameworks/sonnet-${KFMIN}:6
	>=kde-frameworks/syntax-highlighting-${KFMIN}:6
	speech? ( dev-libs/ktextaddons:6[speech=] )
"
DEPEND="${RDEPEND}
	test? ( >=kde-frameworks/ktextwidgets-${KFMIN}:6 )
"

src_configure() {
	local mycmakeargs=(
		$(cmake_use_find_package speech KF6TextEditTextToSpeech)
	)
	ecm_src_configure
}
