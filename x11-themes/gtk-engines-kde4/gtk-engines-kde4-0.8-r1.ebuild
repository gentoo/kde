# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit kde4-base

DESCRIPTION="GTK+2 Qt4 Theme Engine"
MY_PN="gtk-kde4"
HOMEPAGE="http://kde-apps.org/content/show.php/gtk-kde4?content=74689"
SRC_URI="http://kde-apps.org/CONTENT/content-files/74689-${MY_PN}v${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""
RDEPEND=">=x11-libs/qt-gui-4.4.2:4
		x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.6.2"
SLOT="0"

S=${WORKDIR}/${MY_PN}

CMAKE_IN_SOURCE_BUILD="1"

src_configure() {
	cmake-utils_src_configure
}
pkg_postinst() {
	elog "If you want additional themes just download"
	elog "http://betta.h.com.ua/no-site/qt4.tar.gz"
	elog "and put into ~/.themes/ or just use any nice"
	elog "gtk theme."
}
