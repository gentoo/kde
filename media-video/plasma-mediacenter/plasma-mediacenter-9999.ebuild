# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECM_TEST="forceoptional"
inherit ecm kde.org

DESCRIPTION="Unified media experience for any device capable of running KDE Plasma"
HOMEPAGE="https://community.kde.org/Plasma/Plasma_Media_Center"

LICENSE="GPL-2" # TODO: CHECK
SLOT="5"
KEYWORDS=""
IUSE="semantic-desktop"

DEPEND="
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtxml:5
	kde-frameworks/kactivities:5
	kde-frameworks/kconfig:5
	kde-frameworks/kcoreaddons:5
	kde-frameworks/kdeclarative:5
	kde-frameworks/kguiaddons:5
	kde-frameworks/ki18n:5
	kde-frameworks/kio:5
	kde-frameworks/kservice:5
	kde-frameworks/plasma:5
	media-libs/taglib
	semantic-desktop? (
		kde-frameworks/baloo:5
		kde-frameworks/kfilemetadata:5
	)
"
RDEPEND="${DEPEND}
	dev-qt/qtmultimedia:5[qml]
	kde-plasma/plasma-workspace:5
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package semantic-desktop KF5Baloo)
	)

	ecm_src_configure
}
