# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=5.82.0
inherit ecm kde.org

DESCRIPTION="Comic book reader"
HOMEPAGE="https://peruse.kde.org/"

LICENSE="LGPL-2.1+"
SLOT="5"
KEYWORDS=""
IUSE="+semantic-desktop"

DEPEND="
	dev-qt/qtdeclarative:5=
	dev-qt/qtgui:5
	dev-qt/qtopengl:5
	dev-qt/qtsql:5
	dev-qt/qtwidgets:5
	>=kde-frameworks/karchive-${KFMIN}:5
	>=kde-frameworks/kconfig-${KFMIN}:5
	>=kde-frameworks/kcoreaddons-${KFMIN}:5
	>=kde-frameworks/kcrash-${KFMIN}:5
	>=kde-frameworks/kdeclarative-${KFMIN}:5
	>=kde-frameworks/kfilemetadata-${KFMIN}:5
	>=kde-frameworks/kguiaddons-${KFMIN}:5
	>=kde-frameworks/ki18n-${KFMIN}:5
	>=kde-frameworks/kiconthemes-${KFMIN}:5
	>=kde-frameworks/kio-${KFMIN}:5
	>=kde-frameworks/kitemmodels-${KFMIN}:5
	>=kde-frameworks/knewstuff-${KFMIN}:5
	sys-libs/zlib
	semantic-desktop? ( >=kde-frameworks/baloo-${KFMIN}:5 )
"
RDEPEND="${DEPEND}
	dev-qt/qtquickcontrols2:5
	kde-apps/okular[qml]
	>=kde-frameworks/kirigami-${KFMIN}:5
"

src_configure() {
	local mycmakeargs=(
		$(cmake_use_find_package semantic-desktop KF5Baloo)
	)
	ecm_src_configure
}
