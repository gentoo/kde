# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="KdeSudo is a graphical frontend for sudo."
HOMEPAGE="https://launchpad.net/kdesudo"
SRC_URI="http://launchpad.net/kdesudo/3.x/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4.1"
IUSE="debug"

RDEPEND="
	app-admin/sudo
"

pkg_postinst() {
	kde4-base_pkg_postinst

	elog "If you want to replace kdesu with kdesudo ensure,"
	elog "that your PATH variable has /usr/local defined before /usr and"
	elog "run command \"ln -s /usr/bin/kdesudo /usr/local/bin/kdesu\" as root"
}
