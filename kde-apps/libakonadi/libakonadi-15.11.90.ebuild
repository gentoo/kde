# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_DOXYGEN=true
KDE_TEST=true
KMNAME=kdepimlibs
VIRTUALX_REQUIRED=test
inherit kde5

DESCRIPTION="Common akonadi libraries for PIM apps"
KEYWORDS="~amd64 ~x86"
LICENSE="LGPL-2.1"
IUSE="designer tools"

# some akonadi tests time out, that probably needs more work as it's ~700 tests
RESTRICT="test"

COMMON_DEPEND="
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kdesignerplugin)
	$(add_frameworks_dep kguiaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kitemmodels)
	$(add_frameworks_dep kitemviews)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep kxmlgui)
	$(add_kdeapps_dep akonadi)
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtsql:5
	dev-qt/qtxml:5
	dev-qt/qtwidgets:5
	designer? ( dev-qt/designer:5 )
	tools? ( dev-libs/libxml2 )
"
DEPEND="${COMMON_DEPEND}
	dev-libs/boost
	sys-devel/gettext
"
RDEPEND="${COMMON_DEPEND}
	!kde-apps/kdepimlibs
	!kde-base/kdepimlibs:4
"

REQUIRED_USE="test? ( tools )"

S="${WORKDIR}/${P}/akonadi"

src_prepare() {
	epatch "${FILESDIR}/${PN}-15.11.80-testtools-optional.patch"
	if ! use tools ; then
		sed -e "/add_subdirectory(xml)/ s/^/#DONT/" \
			-i src/CMakeLists.txt || die
	fi

	kde5_src_prepare
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package designer Qt5Designer)
		$(cmake-utils_use_build tools)
		$(cmake-utils_use_build test TESTING)
	)
	kde5_src_configure
}
