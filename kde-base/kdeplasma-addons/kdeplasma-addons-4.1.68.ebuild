# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeplasma-addons/kdeplasma-addons-4.1.2.ebuild,v 1.1 2008/10/02 08:12:30 jmbsvicetto Exp $

EAPI="2"

NEED_KDE="4.1"
KMNAME=kdeplasma-addons
OPENGL_REQUIRED="optional"
inherit kde4-base

DESCRIPTION="Extra Plasma applets and engines."
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2 LGPL-2"

KEYWORDS="~amd64 ~x86"
IUSE="xinerama"

DEPEND="
	>=kde-base/kdepimlibs-${PV}:${SLOT}
	>=kde-base/krunner-${PV}:${SLOT}
	>=kde-base/libplasma-${PV}:${SLOT}
	>=kde-base/libtaskmanager-${PV}:${SLOT}
	>=kde-base/plasma-workspace-${PV}:${SLOT}
	xinerama? ( x11-proto/xineramaproto )"
RDEPEND="${DEPEND}
	xinerama? ( x11-libs/libXinerama )"

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DDBUS_INTERFACES_INSTALL_DIR=${KDEDIR}/share/dbus-1/interfaces/
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with xinerama X11_Xinerama)"
	kde4-base_src_configure
}
