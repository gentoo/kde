# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_TEST=true
KMNAME=kdepimlibs
inherit kde5

DESCRIPTION="Library for akonadi contact integration"
KEYWORDS="~amd64 ~x86"
LICENSE="LGPL-2.1"
IUSE="prison"

# some akonadi tests time out, that probably needs more work as it's ~700 tests
RESTRICT="test"

COMMON_DEPEND="
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
	$(add_kdeapps_dep libakonadi)
	$(add_kdeapps_dep akonadi-mime)
	$(add_kdeapps_dep kcalcore)
	$(add_kdeapps_dep kcontacts)
	$(add_kdeapps_dep kmime)
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	media-libs/phonon[qt5]
	prison? ( media-libs/prison:5 )
"
DEPEND="${COMMON_DEPEND}
	sys-devel/gettext
"
RDEPEND="${COMMON_DEPEND}
	!kde-apps/kdepimlibs
"

if [[ ${KDE_BUILD_TYPE} = live ]] ; then
	S="${WORKDIR}/${P}/${PN}"
else
	S="${WORKDIR}/${KMNAME}-${PV}/${PN}"
fi

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package prison KF5Prison)
		$(cmake-utils_use_build test TESTING)
	)
	kde5_src_configure
}
