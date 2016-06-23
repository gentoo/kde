# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_HANDBOOK="forceoptional"
KDE_TEST="true"
QT_MINIMAL="5.6.0"
VIRTUALX_REQUIRED="test"
inherit kde5

DESCRIPTION="Common PIM libraries"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE="ssl"

# drop qtwebengine subslot operator when QT_MINIMAL >= 5.7.0
DEPEND="
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep knewstuff)
	$(add_frameworks_dep kwindowsystem)
	$(add_kdeapps_dep akonadi)
	$(add_kdeapps_dep kidentitymanagement)
	$(add_kdeapps_dep kmailtransport)
	$(add_kdeapps_dep kpimtextedit)
	$(add_kdeapps_dep libkdepim)
	$(add_kdeapps_dep pimcommon)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtwebengine 'widgets' '' '5=')
	$(add_qt_dep qtwidgets)
	$(add_qt_dep qtxml)
	ssl? ( dev-libs/cyrus-sasl )
"
RDEPEND="${DEPEND}
	!kde-apps/kdepim:5
	!kde-apps/kdepim-kioslaves
	!kde-apps/kmail:4
"

src_prepare() {
	kde5_src_prepare

	if ! use_if_iuse handbook ; then
		sed -e "/add_subdirectory(doc)/I s/^/#DONOTCOMPILE /" \
			-i kioslave/CMakeLists.txt || die "failed to comment add_subdirectory(doc)"
	fi
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package ssl Sasl2)
	)
	kde5_src_configure
}
