# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_HANDBOOK="true"
KDE_PUNT_BOGUS_DEPS="true"
KMNAME="kdepim"
inherit kde5

DESCRIPTION="KDE Blogging Client"
HOMEPAGE="https://www.kde.org/applications/internet/blogilo"
KEYWORDS=""

IUSE="google"

DEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kdewebkit)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep ktexteditor)
	$(add_frameworks_dep kwallet)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_kdeapps_dep composereditor)
	$(add_kdeapps_dep kblog)
	$(add_kdeapps_dep libkdepim)
	$(add_kdeapps_dep pimcommon)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtsql)
	$(add_qt_dep qtwebkit)
	$(add_qt_dep qtwidgets)
	dev-libs/libxslt
	google? ( net-libs/libkgapi:5 )
"
RDEPEND="${DEPEND}
	!<kde-apps/kdepim-15.12.2:5
"

if [[ ${KDE_BUILD_TYPE} = live ]] ; then
	S="${WORKDIR}/${P}"
else
	S="${WORKDIR}/${KMNAME}-${PV}"
fi

src_prepare() {
	kde5_src_prepare

	# necessary for 15.12 branch aka split-in-adv-of-upstream
	sed -e '/^include.*kleopatra\/ConfigureChecks/ s/^/#DONT/' \
		-i CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=(
		-DKDEPIM_BUILD_WITH_INSTALLED_LIB=TRUE
		-DCMAKE_DISABLE_FIND_PACKAGE_KF5Prison=ON
		-DCMAKE_DISABLE_FIND_PACKAGE_Qt5Designer=ON
		-DCMAKE_DISABLE_FIND_PACKAGE_Qt5X11Extras=ON
		$(cmake-utils_use_find_package google KF5GAPI)
	)

	kde5_src_configure
}
