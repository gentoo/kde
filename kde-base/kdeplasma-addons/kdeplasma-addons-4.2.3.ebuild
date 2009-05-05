# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeplasma-addons/kdeplasma-addons-4.2.2.ebuild,v 1.2 2009/04/17 06:38:33 alexxy Exp $

EAPI="2"

KMNAME="kdeplasma-addons"
OPENGL_REQUIRED="optional"
WEBKIT_REQUIRED="always"
inherit kde4-base

DESCRIPTION="Extra Plasma applets and engines."
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2 LGPL-2"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug xinerama"

DEPEND="
	>=kde-base/kdepimlibs-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/krunner-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/plasma-workspace-${PV}:${SLOT}[kdeprefix=]
	opengl? ( >=kde-base/kdelibs-${PV}:${SLOT}[kdeprefix=,opengl] )
	xinerama? ( x11-proto/xineramaproto )
"
RDEPEND="${DEPEND}
	!kdeprefix? ( !kde-misc/lancelot-menu )
	xinerama? ( x11-libs/libXinerama )
"

PATCHES=( "${FILESDIR}/lancelot-qt45.patch" )

src_prepare() {
	sed -i -e 's/${KDE4WORKSPACE_PLASMACLOCK_LIBRARY}/plasmaclock/g' \
		-e 's/${KDE4WORKSPACE_WEATHERION_LIBRARY}/weather_ion/g' \
		-e 's/${KDE4WORKSPACE_TASKMANAGER_LIBRARY}/taskmanager/g' \
		applets/{binary-clock,fuzzy-clock,weather_station,lancelot/app/src}/CMakeLists.txt \
		|| die "Failed to patch CMake files"

	sed -i -e 's/(KDE4_PLASMA_OPENGL_FOUND)/(KDE4_PLASMA_OPENGL_FOUND AND OPENGL_FOUND)/g' \
		applets/CMakeLists.txt \
		|| die "Failed to make OpenGL applets optional"

	kde4-base_src_prepare
}

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DDBUS_INTERFACES_INSTALL_DIR=${KDEDIR}/share/dbus-1/interfaces/
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with xinerama X11_Xinerama)"

	kde4-base_src_configure
}
