# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

NEED_KDE="4.1"
inherit kde4-base

DESCRIPTION="KdeSudo is a graphical frontend for sudo."
HOMEPAGE="https://launchpad.net/kdesudo"
SRC_URI="http://launchpad.net/kdesudo/3.x/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4.1"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-admin/sudo
	>=kde-base/kdebase-data-4.1.0"
RDEPEND="${DEPEND}"

PREFIX="${KDEDIR}"

src_install() {
	kde4-base_src_install
	dosym /usr/bin/kdesudo /usr/local/bin/kdesu
}

pkg_postinst() {
	elog "Kdesudo does symlink to /usr/local/bin/kdesu"
	elog "if you want to use kdesu remove that symlink,"
	elog "or use absolute path to your kdesu (${PREFIX}/bin/kdesu)."
	elog
	elog "This expects that your PATH has definition of /usr/local/"
	elog "before /usr/"
}
