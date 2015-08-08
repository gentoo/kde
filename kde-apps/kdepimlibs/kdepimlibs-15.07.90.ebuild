# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_HANDBOOK=true
KDE_TEST=true
inherit kde5

DESCRIPTION="Common library for KDE PIM apps"
KEYWORDS="~amd64 ~x86"
LICENSE="LGPL-2.1"
IUSE="designer prison ssl"

# some akonadi tests time out, that probably needs more work as it's ~700 tests
RESTRICT="test"

COMMON_DEPEND="
	$(add_frameworks_dep kbookmarks)
	$(add_frameworks_dep kcodecs)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep kguiaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kitemmodels)
	$(add_frameworks_dep kitemviews)
	$(add_frameworks_dep kparts)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep solid)
	$(add_kdeapps_dep akonadi)
	$(add_kdeapps_dep kcalcore)
	$(add_kdeapps_dep kcontacts)
	$(add_kdeapps_dep kldap)
	$(add_kdeapps_dep kmbox)
	$(add_kdeapps_dep kmime)
	dev-libs/libxml2
	dev-libs/libxslt
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtsql:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	media-libs/phonon[qt5]
	x11-misc/shared-mime-info
	designer? ( dev-qt/designer:5 )
	prison? ( media-libs/prison:5 )
	ssl? ( dev-libs/cyrus-sasl )
"
DEPEND="${COMMON_DEPEND}
	dev-libs/boost
"
RDEPEND="${COMMON_DEPEND}
	!kde-base/kdepimlibs
"

src_prepare() {
	use handbook || \
		sed -e '/^find_package.*KF5DocTools/ s/^/#/' \
			-e '/^add_subdirectory(docs)/ s/^/#/' \
			-i kioslave/CMakeLists.txt || die
	# kdepimlibs contains many projects for which we have to run our kde5_src_prepare
	for d in $(find "${S}" -maxdepth 1 -type d); do
		pushd "$d"
		kde5_src_prepare
		popd
	done
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package designer Qt5Designer)
		$(cmake-utils_use_find_package prison KF5Prison)
		$(cmake-utils_use_find_package ssl Sasl2)
		$(cmake-utils_use_build test TESTING)
	)
	kde5_src_configure
}
