# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

NEED_KDE="svn"
OPENGL_REQUIRED="optional"
inherit kde4svn

PREFIX="${KDEDIR}"

DESCRIPTION="Extra Plasma applets and engines."
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2 LGPL-2"

KEYWORDS=""
IUSE=""

DEPEND="!kde-misc/extragear-plasma:${SLOT}
	!kde-base/kdeplasmoids:${SLOT}
	>=kde-base/qimageblitz-0.0.4
	kde-base/krunner:${SLOT}
	kde-base/libtaskmanager:${SLOT}
	kde-base/libplasma:${SLOT}
	kde-base/plasma-workspace:${SLOT}
	opengl? ( virtual/opengl )"
RDEPEND="${DEPEND}"

src_compile() {
	# Dir doesn't exist
	sed -e '/tutorial/d' \
		-i "${S}"/applets/CMakeLists.txt \
		|| die "Removing tutorial line failed."
	mycmakeargs="${mycmakeargs}
		-DDBUS_INTERFACES_INSTALL_DIR=${KDEDIR}/share/dbus-1/interfaces/
		$(cmake-utils_use_with opengl OpenGL)"
	kde4overlay-base_src_compile
}
