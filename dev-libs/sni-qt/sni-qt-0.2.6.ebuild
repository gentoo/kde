# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils

DESCRIPTION="A Qt plugin which turns all QSystemTrayIcon into StatusNotifierItems"
HOMEPAGE="https://launchpad.net/sni-qt"
SRC_URI="https://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.bz2"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-libs/libdbusmenu-qt
	dev-qt/qtcore"
DEPEND="${RDEPEND}"
