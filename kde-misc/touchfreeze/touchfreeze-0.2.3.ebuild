# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils qt4

DESCRIPTION="X11 touch pad driver configuration utility"
HOMEPAGE="http://qsynaptics.sourceforge.net/"
SRC_URI="http://qsynaptics.sourceforge.net/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="x11-drivers/xf86-input-synaptics"
RDEPEND="${DEPEND}"

src_compile() {
	eqmake4 TouchFreeze.pro || die "eqmake failed"
	emake || die "emake failed"
}

src_install() {
	dobin ${PN}
	newicon res/touchpad.svg ${PN}.svg
	dodoc AUTHORS README
	make_desktop_entry ${PN}
}
