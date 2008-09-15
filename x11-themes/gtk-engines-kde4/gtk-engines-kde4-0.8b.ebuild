# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"
NEED_KDE=4.1
inherit qt4 kde4-base

DESCRIPTION="GTK+2 Qt4 Theme Engine"
MY_PN="gtk-kde4"
HOMEPAGE="http://kde-apps.org/content/show.php/gtk-kde4?content=74689"
SRC_URI="http://betta.h.com.ua/no-site/${MY_PN}v${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=">=dev-util/cmake-2.6.1
	|| (
		>=x11-libs/qt-4.4.1:4
		( >=x11-libs/qt-core-4.4.1:4 >=x11-libs/qt-gui-4.4.1:4 )
	)
	>=kde-base/kdelibs-4.1.0:${SLOT}
	x11-libs/gtk+:2"
RDEPEND="${DEPEND}"
SLOT="0"

S=${WORKDIR}/${MY_PN}

src_compile() {
	cmake . || die "cmake failed"
	emake || die "emake failed"
}

pkg_postinst() {
	elog "If you want additional themes just download"
	elog "http://betta.h.com.ua/no-site/qt4.tar.gz"
	elog "and put into ~/.themes/"
}
