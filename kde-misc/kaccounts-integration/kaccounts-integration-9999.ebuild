# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5

DESCRIPTION="KDE KAccount integration"
HOMEPAGE="https://community.kde.org/KTp"

LICENSE="LGPL-2.1"
SLOT="5"
IUSE="test"

DEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kwallet)
	$(add_frameworks_dep kwidgetsaddons)
	net-libs/accounts-qt
	net-libs/signond
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
"
RDEPEND="${DEPEND}"

src_prepare() {
	if ! use test; then
		sed -i -e 's/add_subdirectory(tests)//' CMakeLists.txt || die "couldn't disable tests"
	fi

	kde5_src_prepare
}
