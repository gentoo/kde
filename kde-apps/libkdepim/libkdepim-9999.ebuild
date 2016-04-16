# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_TEST="true"
VIRTUALX_REQUIRED="test"
inherit kde5

DESCRIPTION="Common PIM libraries"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE="designer"

COMMON_DEPEND="
	$(add_frameworks_dep kcmutils)
	$(add_frameworks_dep kcodecs)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kitemviews)
	$(add_frameworks_dep kwallet)
	$(add_kdeapps_dep akonadi)
	$(add_kdeapps_dep akonadi-contact)
	$(add_kdeapps_dep akonadi-search)
	$(add_kdeapps_dep kcontacts)
	$(add_kdeapps_dep kldap)
	$(add_kdeapps_dep kmime)
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtnetwork)
	$(add_qt_dep qtwidgets)
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
