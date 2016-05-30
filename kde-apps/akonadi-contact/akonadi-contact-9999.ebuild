# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_TEST="forceoptional"
KMNAME="kdepimlibs"
QT_MINIMAL="5.6.0"
inherit kde5

DESCRIPTION="Library for akonadi contact integration"
KEYWORDS=""
LICENSE="LGPL-2.1"
IUSE="prison"

# some akonadi tests time out, that probably needs more work as it's ~700 tests
RESTRICT="test"

DEPEND="
	$(add_frameworks_dep kcodecs)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kitemmodels)
	$(add_frameworks_dep kjobwidgets)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_kdeapps_dep akonadi)
	$(add_kdeapps_dep akonadi-mime)
	$(add_kdeapps_dep kcalcore)
	$(add_kdeapps_dep kcontacts)
	$(add_kdeapps_dep kmime)
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtwebengine 'widgets')
	$(add_qt_dep qtwidgets)
	>=dev-libs/grantlee-5.1.0:5
	prison? ( media-libs/prison:5 )
"
RDEPEND="${DEPEND}
	!kde-apps/kdepim
	!kde-apps/kdepimlibs:4
	!kde-apps/kdepimlibs:5
"

if [[ ${KDE_BUILD_TYPE} = live ]] ; then
	S="${WORKDIR}/${P}/${PN}"
else
	S="${WORKDIR}/${KMNAME}-${PV}/${PN}"
fi

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package prison KF5Prison)
	)
	kde5_src_configure
}
