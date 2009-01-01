# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdeplasma-addons"
OPENGL_REQUIRED="optional"
inherit kde4-base

DESCRIPTION="Extra Plasma applets and engines."
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2 LGPL-2"

KEYWORDS="~amd64 ~x86"
IUSE="xinerama"

DEPEND="
	>=kde-base/krunner-${PV}:${SLOT}
	>=kde-base/plasma-workspace-${PV}:${SLOT}
	xinerama? ( x11-proto/xineramaproto )"
RDEPEND="${DEPEND}
	xinerama? ( x11-libs/libXinerama )"

src_prepare() {
	sed -i -e 's/${KDE4WORKSPACE_PLASMACLOCK_LIBRARY}/plasmaclock/g' \
		-e 's/${KDE4WORKSPACE_WEATHERION_LIBRARY}/weather_ion/g' \
		-e 's/${KDE4WORKSPACE_TASKMANAGER_LIBRARY}/taskmanager/g' \
		applets/{binary-clock,fuzzy-clock,weather_station,lancelot/app/src}/CMakeLists.txt \
		|| die "Failed to patch CMake files"

	kde4-base_src_prepare
}

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DDBUS_INTERFACES_INSTALL_DIR=${KDEDIR}/share/dbus-1/interfaces/
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with xinerama X11_Xinerama)"
	kde4-base_src_configure
}
