# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_TEST="false"
KMNAME="kdepim"
inherit kde5

DESCRIPTION="Common mail library"
LICENSE="LGPL-2+"
KEYWORDS=" ~amd64 ~x86"
IUSE="designer"

COMMON_DEPEND="
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep kcodecs)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kitemviews)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep kxmlgui)
	$(add_kdeapps_dep akonadi-mime)
	$(add_kdeapps_dep kldap)
	$(add_kdeapps_dep kmailtransport)
	$(add_kdeapps_dep kmime)
	$(add_kdeapps_dep libakonadi)
	$(add_kdeapps_dep libkdepim)
	$(add_kdeapps_dep mailimporter)
	$(add_kdeapps_dep messagecomposer)
	$(add_kdeapps_dep messagecore)
	$(add_kdeapps_dep messageviewer)
	$(add_kdeapps_dep pimcommon)
	$(add_kdeapps_dep templateparser)
	dev-libs/libxslt
	$(add_qt_dep qtgui)
	$(add_qt_dep qtwidgets)
	media-libs/phonon[qt5]
"
DEPEND="${COMMON_DEPEND}
	sys-devel/gettext
	designer? ( $(add_qt_dep designer) )
"
RDEPEND="${COMMON_DEPEND}
	!<kde-apps/kdepim-15.08.50:5
	!kde-apps/kdepim-common-libs:4
"

if [[ ${KDE_BUILD_TYPE} = live ]] ; then
	S="${WORKDIR}/${P}/${PN}"
else
	S="${WORKDIR}/${KMNAME}-${PV}/${PN}"
fi

PATCHES=( "${FILESDIR}/${PN}-15.12.0-find-qt5designer.patch" )

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package designer Qt5Designer)
	)
	kde5_src_configure
}
