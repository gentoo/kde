# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

NEED_KDE="4.1"
OPENGL_REQUIRED="optional"
inherit eutils kde4-base

DESCRIPTION="Experimental Plasma applets and engines."
HOMEPAGE="http://www.kde.org/"
SRC_URI="http://hlukotvor.no-ip.org/plasma-playground-20080907.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="python"

DEPEND=">=kde-base/libplasma-4.1.0
	>=kde-base/kdepimlibs-4.1.0
	>=kde-base/plasma-workspace-4.1.0
	>=kde-base/ksmserver-4.1.0
	x11-libs/qt-webkit
	kde-base/qimageblitz
	>=dev-util/cmake-2.6.1
	python? ( dev-lang/python:2.5 )"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-cmakelists.patch
}

src_compile() {
	mycmakeargs="${mycmakeargs}
		-DDBUS_INTERFACES_INSTALL_DIR=${KDEDIR}/share/dbus-1/interfaces/
		-DSENSORS_FOUND=No
		-DWITH_Sensors=Off
		-DWITH_Blitz=On
		-DWITH_KdepimLibs=On
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with python PythonLibs)"
	kde4-base_src_compile
}
