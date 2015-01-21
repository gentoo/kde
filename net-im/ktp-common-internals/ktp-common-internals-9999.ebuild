# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_TEST="true"
inherit kde5

DESCRIPTION="KDE Telepathy common library"
HOMEPAGE="http://community.kde.org/Real-Time_Communication_and_Collaboration"
if [[ ${PV} != *9999* ]]; then
	SRC_URI="mirror://kde/stable/kde-telepathy/${PV}/src/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
else
	KEYWORDS=""
fi

LICENSE="LGPL-2.1"
SLOT="5"
IUSE="doc otr"

# todo: libkpeople, kdepimlibs
DEPEND="
	$(add_frameworks_dep kcmutils)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep knotifyconfig)
	$(add_frameworks_dep kparts)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep ktexteditor)
	$(add_frameworks_dep kwallet)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep kxmlgui)
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	kde-misc/kaccounts-integration
	media-libs/qt-gstreamer
	net-libs/accounts-qt
	>=net-libs/telepathy-qt-0.9.5[qt5]
	net-libs/telepathy-logger-qt:5
	doc? (
		app-doc/doxygen
	)
	otr? (
		dev-libs/libgcrypt:0=
		>=net-libs/libotr-4.0.0
	)
"
RDEPEND="${DEPEND}
	!net-im/ktp-common-internals:4
"

PATCHES=( "${FILESDIR}/${PN}-9999-tests-optional.patch" )

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package doc Doxygen)
		$(cmake-utils_use_find_package otr Libgcrypt)
		$(cmake-utils_use_find_package otr LibOTR)
	)

	kde5_src_configure
}

src_compile() {
	kde5_src_compile
	use doc && kde5_src_compile apidox
}

src_install() {
	kde5_src_install
	use doc && dodoc "${BUILD_DIR}"/KTp/docs/html/*
}
