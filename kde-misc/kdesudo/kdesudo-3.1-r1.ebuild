# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

NEED_KDE="4.1"
inherit kde4-base

DESCRIPTION="KdeSudo is a graphical frontend for sudo."
HOMEPAGE="https://launchpad.net/kdesudo"
SRC_URI="http://launchpad.net/kdesudo/3.x/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-admin/sudo
	>=kde-base/kdebase-data-4.1.0"
RDEPEND="${DEPEND}"

PREFIX="${KDEDIR}"

pkg_postinst() {
	elog "If you want to replace kdesu with kdesudo ensure yourself,"
	elog "that your PATH variable has /usr/local defined before /usr and"
	elog "run command \"ln -s /usr/bin/kdesudo /usr/local/bin/kdesu\" as root"
}
