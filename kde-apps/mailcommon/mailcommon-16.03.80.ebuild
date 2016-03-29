# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_TEST="false"
inherit kde5

DESCRIPTION="Common mail library"
LICENSE="LGPL-2+"
KEYWORDS="~amd64 ~arm ~x86"
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
	$(add_kdeapps_dep akonadi)
	$(add_kdeapps_dep akonadi-mime)
	$(add_kdeapps_dep kldap)
	$(add_kdeapps_dep kmailtransport)
	$(add_kdeapps_dep kmime)
	$(add_kdeapps_dep libkdepim)
	$(add_kdeapps_dep mailimporter)
	$(add_kdeapps_dep messagelib)
	$(add_kdeapps_dep pimcommon)
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

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package designer Qt5Designer)
	)
	kde5_src_configure
}
