# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

FRAMEWORKS_MINIMAL="5.19.0"
KDE_HANDBOOK="false"
KDE_PIM_KONTACTPLUGIN="true"
KDE_TEST="false"
KMNAME="kdepim"
inherit kde5

DESCRIPTION="News feed aggregator"
HOMEPAGE="https://www.kde.org/applications/internet/akregator"
KEYWORDS="~amd64 ~arm ~x86"

IUSE=""

COMMON_DEPEND="
	$(add_frameworks_dep kcmutils)
	$(add_frameworks_dep kcodecs)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep khtml)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kjobwidgets)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep knotifyconfig)
	$(add_frameworks_dep kparts)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep kxmlgui)
	$(add_kdeapps_dep kpimtextedit)
	$(add_kdeapps_dep libkdepim)
	$(add_kdeapps_dep pimcommon)
	$(add_kdeapps_dep syndication)
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtnetwork)
	$(add_qt_dep qtwidgets)
	$(add_qt_dep qtxml)
	dev-libs/grantlee:5
	dev-libs/libxslt
"
DEPEND="${COMMON_DEPEND}
	sys-devel/gettext
"
RDEPEND="${COMMON_DEPEND}
	!<kde-apps/kdepim-15.12.2:5
"

if [[ ${KDE_BUILD_TYPE} = live ]] ; then
	S="${WORKDIR}/${P}"
else
	S="${WORKDIR}/${KMNAME}-${PV}"
fi

src_configure() {
	local mycmakeargs=(
		-DCMAKE_DISABLE_FIND_PACKAGE_KF5GAPI=ON
		-DCMAKE_DISABLE_FIND_PACKAGE_KF5Prison=ON
		-DCMAKE_DISABLE_FIND_PACKAGE_Qt5Designer=ON
		-DCMAKE_DISABLE_FIND_PACKAGE_Qt5X11Extras=ON
	)

	kde5_src_configure
}
