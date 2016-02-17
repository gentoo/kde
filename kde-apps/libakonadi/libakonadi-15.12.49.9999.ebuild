# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_DOXYGEN=true
KDE_TEST=true
KMNAME=kdepimlibs
VIRTUALX_REQUIRED=test
inherit kde5

DESCRIPTION="Common akonadi libraries for PIM apps"
KEYWORDS=""
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
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtnetwork)
	$(add_qt_dep qtsql)
	$(add_qt_dep qtxml)
	$(add_qt_dep qtwidgets)
	designer? ( $(add_qt_dep designer) )
	tools? ( dev-libs/libxml2 )
"
DEPEND="${COMMON_DEPEND}
	dev-libs/boost
	sys-devel/gettext
"
RDEPEND="${COMMON_DEPEND}
	!kde-apps/kdepimlibs
"

REQUIRED_USE="test? ( tools )"

if [[ ${KDE_BUILD_TYPE} = live ]] ; then
	S="${WORKDIR}/${P}/akonadi"
else
	S="${WORKDIR}/${KMNAME}-${PV}/akonadi"
fi

PATCHES=( "${FILESDIR}/${PN}-15.12.2-testtools-optional.patch" )

src_prepare() {
	kde5_src_prepare
	if ! use tools ; then
		sed -e "/add_subdirectory(xml)/ s/^/#DONT/" \
			-i src/CMakeLists.txt || die
	fi
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package designer Qt5Designer)
		-DBUILD_TESTING=$(usex test)
		-DBUILD_TOOLS=$(usex tools)
	)
	kde5_src_configure
}
