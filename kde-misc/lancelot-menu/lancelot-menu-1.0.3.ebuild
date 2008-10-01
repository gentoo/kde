# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

NEED_KDE="4.1"
OPENGL_REQUIRED="always"
inherit kde4-base

DESCRIPTION="Kool Kickoff replacement with many features"
HOMEPAGE="http://lancelot.fomentgroup.org/"
SRC_URI="mirror://sourceforge/${PN}/lancelot-${PV}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="4.1"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="kde-base/libplasma:${SLOT}
	kde-base/kscreensaver:${SLOT}"
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.6.1
	dev-lang/python"

S=${WORKDIR}/lancelot-${PV}

PREFIX=${KDEDIR}

src_configure() {
	local mycmakeargs
	mycmakeargs="${mycmakeargs}
		-DDBUS_INTERFACES_INSTALL_DIR=${KDEDIR}/share/dbus-1/interfaces/"
	kde4-base_src_configure
}
