# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_HANDBOOK="true"
KDE_PIM_KEEP_SUBDIR="noteshared"
KDE_PIM_KONTACTPLUGIN="true"
KDE_PUNT_BOGUS_DEPS="true"
KMNAME="kdepim"
QT_MINIMAL="5.6.0"
inherit kde5

DESCRIPTION="KDE Notes application"
HOMEPAGE="https://www.kde.org/"
KEYWORDS=""

IUSE=""

DEPEND="
	$(add_frameworks_dep kcmutils)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep kdnssd)
	$(add_frameworks_dep kglobalaccel)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kitemmodels)
	$(add_frameworks_dep knewstuff)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep kxmlgui)
	$(add_kdeapps_dep akonadi)
	$(add_kdeapps_dep akonadi-notes)
	$(add_kdeapps_dep akonadi-search)
	$(add_kdeapps_dep kmime)
	$(add_kdeapps_dep pimcommon)
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtprintsupport)
	$(add_qt_dep qtwidgets)
	$(add_qt_dep qtx11extras)
	$(add_qt_dep qtxml)
	dev-libs/grantlee:5
	dev-libs/libxslt
	x11-libs/libX11
	kontact? (
		$(add_frameworks_dep kitemviews)
		$(add_frameworks_dep kparts)
		$(add_kdeapps_dep kcalcore)
		$(add_kdeapps_dep kcalutils)
		$(add_kdeapps_dep kcontacts)
		$(add_kdeapps_dep libkdepim)
	)
"
RDEPEND="${DEPEND}
	!<kde-apps/kdepim-15.12.2:5
	!kde-apps/noteshared:5
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
	)
# 	# FIXME: Does not build (last checked 2016-02-17)
# 		$(cmake-utils_use_find_package X Qt5X11Extras)
# 		$(cmake-utils_use_find_package X X11)

	kde5_src_configure
}
