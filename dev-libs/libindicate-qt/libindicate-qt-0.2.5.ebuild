# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libindicate-qt/libindicate-qt-0.2.2.ebuild,v 1.2 2010/02/16 17:15:56 josejx Exp $

EAPI=2

inherit cmake-utils

DESCRIPTION="QT wrapper for libindicate library"
HOMEPAGE="https://launchpad.net/libindicate-qt/"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.bz2"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=dev-libs/libindicate-0.3.3
	x11-libs/qt-gui:4
"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
"
