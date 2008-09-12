# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

NEED_KDE="4.1"
OPENGL_REQUIRED="always"
inherit kde4-base

DESCRIPTION="Kool Kickoff replacement with many features"
HOMEPAGE="http://lancelot.fomentgroup.org/"
SRC_URI="mirror://sourceforge/${PN}/${P/-menu/}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND=">=kde-base/libplasma-4.1.0
	>=kde-base/kscreensaver-4.1.0"
DEPEND="${RDEPEND}
	dev-lang/python
	>=dev-util/cmake-2.6.0"

S=${WORKDIR}/${PN/-menu/}

PREFIX=${KDEDIR}

src_compile() {
	local mycmakeargs
	mycmakeargs="${mycmakeargs}
		-DDBUS_INTERFACES_INSTALL_DIR=${KDEDIR}/share/dbus-1/interfaces/"
	kde4-base_src_compile
}

src_install() {
	# lancelot has broken install with FSH (dunno why)
	cd "${WORKDIR}"/lancelot-menu_build/libs/lancelot/
	make DESTDIR="${D}" install
	cd "${WORKDIR}"/lancelot-menu_build/app/
	make DESTDIR="${D}" install
	cd "${S}"
	cmake-utils_src_install
}
