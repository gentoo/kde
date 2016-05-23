# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_HANDBOOK="forceoptional"
KDE_PUNT_BOGUS_DEPS="true"
KMNAME="kdepim"
QT_MINIMAL="5.6.0"
inherit kde5

DESCRIPTION="A viewer for TNEF attachments"
HOMEPAGE="https://www.kde.org/"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_kdeapps_dep libktnef)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtwidgets)
"
RDEPEND="${DEPEND}
	!kde-apps/kdepim:5
"

src_prepare() {
	# ktnef subproject does not contain doc nor searches for DocTools
	# at least until properly split upstream
	echo "add_subdirectory(doc)" >> CMakeLists.txt || die "Failed to add doc dir"

	mkdir doc || die "Failed to create doc dir"
	mv ../doc/${PN} doc || die "Failed to move handbook"
	cat <<-EOF > doc/CMakeLists.txt
find_package(KF5DocTools)
add_subdirectory(${PN})
EOF
	kde5_src_prepare
}
