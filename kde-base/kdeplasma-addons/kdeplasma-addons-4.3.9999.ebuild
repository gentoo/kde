# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdeplasma-addons"
OPENGL_REQUIRED="optional"
WEBKIT_REQUIRED="always"
inherit kde4-base

DESCRIPTION="Extra Plasma applets and engines."
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2 LGPL-2"

KEYWORDS=""
IUSE="debug desktopglobe exif semantic-desktop"

# krunner is only needed to generate dbus interface for lancelot
COMMON_DEPEND="
	>=kde-base/kdelibs-${PV}:${SLOT}[kdeprefix=,opengl?,semantic-desktop?]
	>=kde-base/kdepimlibs-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/krunner-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/plasma-workspace-${PV}:${SLOT}[kdeprefix=]
	x11-misc/shared-mime-info
	desktopglobe? ( >=kde-base/marble-${PV}:${SLOT}[kdeprefix=] )
	exif? ( >=kde-base/libkexiv2-${PV}:${SLOT}[kdeprefix=] )
"
DEPEND="${COMMON_DEPEND}
	dev-cpp/eigen:2
"
RDEPEND="${COMMON_DEPEND}
	semantic-desktop? ( >=kde-base/nepomuk-${PV}:${SLOT}[kdeprefix=] )
"

# kdebase-data: some svg icons moved from data directly here.
add_blocker kdebase-data '<4.2.88'

src_prepare() {
	sed -i -e 's/${KDE4WORKSPACE_PLASMACLOCK_LIBRARY}/plasmaclock/g' \
		-e 's/${KDE4WORKSPACE_WEATHERION_LIBRARY}/weather_ion/g' \
		-e 's/${KDE4WORKSPACE_TASKMANAGER_LIBRARY}/taskmanager/g' \
		{libs/plasmaweather,applets/{binary-clock,fuzzy-clock,weather,weatherstation,lancelot/app/src}}/CMakeLists.txt \
		|| die "Failed to patch CMake files"

	sed -i -e 's/(KDE4_PLASMA_OPENGL_FOUND)/(KDE4_PLASMA_OPENGL_FOUND AND OPENGL_FOUND)/g' \
		applets/CMakeLists.txt \
		|| die "Failed to make OpenGL applets optional"

	kde4-base_src_prepare
}

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DDBUS_INTERFACES_INSTALL_DIR=${KDEDIR}/share/dbus-1/interfaces/
		$(cmake-utils_use_with exif Kexiv2)
		$(cmake-utils_use_with desktopglobe Marble)
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with semantic-desktop Nepomuk)"

	kde4-base_src_configure
}
