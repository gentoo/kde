# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit cmake-utils

DESCRIPTION="A library providing Qt implementation of DBusMenu specification"
HOMEPAGE="http://people.canonical.com/~agateau/dbusmenu/"
SRC_URI="http://people.canonical.com/~agateau/dbusmenu/${P}.tar.bz2"

LICENSE="LGPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug"

DEPEND="
	x11-libs/qt-core:4
	x11-libs/qt-gui:4[dbus]
	x11-libs/qt-test:4
"
RDEPEND="${DEPEND}"
