# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_TEST=true
inherit kde5

DESCRIPTION="Administer web accounts for the sites and services across the KDE desktop"
HOMEPAGE="https://community.kde.org/KTp"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
IUSE="semantic-desktop test"

DEPEND="
	$(add_frameworks_dep kcmutils)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kwallet)
	$(add_frameworks_dep kwidgetsaddons)
	dev-qt/qtgui:5
	test? ( dev-qt/qttest:5 )
	dev-qt/qtwidgets:5
	net-libs/accounts-qt
	net-libs/signond
"
RDEPEND="${DEPEND}"

src_prepare() {
	! use test && comment_add_subdirectory tests
	kde5_src_prepare
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_find_package semantic-desktop KF5Akonadi)
	)
	kde5_src_configure
}
