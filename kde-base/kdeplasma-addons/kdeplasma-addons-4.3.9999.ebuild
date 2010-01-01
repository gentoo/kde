# Copyright 1999-2010 Gentoo Foundation
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
RDEPEND="
	$(add_kdebase_dep kdelibs 'opengl?,semantic-desktop?')
	$(add_kdebase_dep kdepimlibs)
	$(add_kdebase_dep krunner)
	$(add_kdebase_dep plasma-workspace)
	x11-misc/shared-mime-info
	desktopglobe? ( $(add_kdebase_dep marble) )
	exif? ( $(add_kdebase_dep libkexiv2) )
"
DEPEND="${RDEPEND}
	dev-cpp/eigen:2
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
	mycmakeargs=(
		-DDBUS_INTERFACES_INSTALL_DIR="${EKDEDIR}/share/dbus-1/interfaces/"
		$(cmake-utils_use_with exif Kexiv2)
		$(cmake-utils_use_with desktopglobe Marble)
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with semantic-desktop Nepomuk)
	)

	kde4-base_src_configure
}
