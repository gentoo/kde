# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME="playground/base"
KMMODULE="plasma"

NEED_KDE="svn"
SLOT="kde-svn"

OPENGL_REQUIRED="optional"
inherit kde4svn

DESCRIPTION="(Very) experimental Plasma applets and engines."
HOMEPAGE="http://www.kde.org/"

PREFIX=${KDEDIR}
KEYWORDS=""
IUSE="python"
LICENSE="GPL-2 LGPL-2"

DEPEND="kde-base/libplasma:${SLOT}
	kde-base/kdepimlibs:${SLOT}
	kde-base/plasma-workspace:${SLOT}
	x11-libs/qt-webkit
	kde-base/qimageblitz
	python? ( dev-lang/python:2.5 )"
RDEPEND="${DEPEND}"

src_compile() {
	mycmakeargs="${mycmakeargs}
		-DSENSORS_FOUND=No
		-DWITH_Sensors=Off
		-DWITH_Blitz=On
		-DWITH_KdepimLibs=On
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with python PythonLibs)"

	# Fix:
#		$(cmake-utils_use_with sensors Sensors)
	kde4overlay-base_src_compile
}
