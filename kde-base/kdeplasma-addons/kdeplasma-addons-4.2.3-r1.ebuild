# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeplasma-addons/kdeplasma-addons-4.2.3-r1.ebuild,v 1.1 2009/05/20 14:58:23 tampakrap Exp $

EAPI="2"

KMNAME="kdeplasma-addons"
OPENGL_REQUIRED="optional"
WEBKIT_REQUIRED="always"
inherit kde4-base

DESCRIPTION="Extra Plasma applets and engines."
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2 LGPL-2"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug exif"

# krunner is only needed to generate dbus interface for lancelot
DEPEND="
	>=kde-base/kdelibs-${PV}:${SLOT}[kdeprefix=,opengl?]
	>=kde-base/kdepimlibs-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/krunner-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/plasma-workspace-${PV}:${SLOT}[kdeprefix=]
	exif? ( >=kde-base/libkexiv2-${PV}:${SLOT}[kdeprefix=] )
"
RDEPEND="${DEPEND}
	!kdeprefix? ( !kde-misc/lancelot-menu )
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
		$(cmake-utils_use_with exif Kexiv2)
		$(cmake-utils_use_with opengl OpenGL)"

	kde4-base_src_configure
}
