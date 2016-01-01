# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_AUTODEPS="false"
KDE_TEST="forceoptional"
QT_MINIMAL="5.5.1"
inherit kde5

DESCRIPTION="A fast heap memory profiler"
HOMEPAGE="http://milianw.de/blog/heaptrack-a-heap-memory-profiler-for-linux"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="+qt5"

COMMON_DEPEND="
	dev-libs/boost
	sys-libs/libunwind
	sys-libs/zlib
	qt5? (
		$(add_frameworks_dep extra-cmake-modules)
		$(add_frameworks_dep kconfig)
		$(add_frameworks_dep kconfigwidgets)
		$(add_frameworks_dep kcoreaddons)
		$(add_frameworks_dep ki18n)
		$(add_frameworks_dep kitemmodels)
		$(add_frameworks_dep threadweaver)
		$(add_kdeapps_dep kdiagram)
		>=dev-qt/qtcore-${QT_MINIMAL}:5
		>=dev-qt/qtgui-${QT_MINIMAL}:5
		>=dev-qt/qtwidgets-${QT_MINIMAL}:5
	)
"
DEPEND="${COMMON_DEPEND}
	sys-devel/gettext
"
RDEPEND="${COMMON_DEPEND}
	qt5? ( >=kde-frameworks/kf-env-3 )
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package qt5)
		$(cmake-utils_use_find_package qt5 ECM)
		$(cmake-utils_use_find_package qt5 KChart)
	)

	kde5_src_configure
}
