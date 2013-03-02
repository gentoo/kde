# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils

DESCRIPTION="QT-style Interface for libinfinity"
HOMEPAGE="http://kobby.greghaynes.net/wiki/libqinfinity"
SRC_URI="http://kobby.greghaynes.net/file-cabinet/${P/_beta/b}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug"

DEPEND="
	dev-libs/glib:2
	dev-libs/libxml2
	>=net-libs/libinfinity-0.4.1
	dev-qt/qtcore:4
	>=virtual/gsasl-1.4.0
"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P/_beta/b}
