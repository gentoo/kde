# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit cmake-utils

DESCRIPTION="Little CMS ICC profile construction set"
HOMEPAGE="http://lprof.sourceforge.net/"
SRC_URI="http://dev.gentooexperimental.org/~tampakrap/${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~amd64"
SLOT="0"
IUSE="debug"

DEPEND="
	dev-libs/openssl
	media-libs/libpng
	media-libs/tiff
	media-libs/jpeg
	media-libs/vigra
	sys-libs/zlib
	virtual/libusb
	x11-libs/qt-core:4[qt3support]
	x11-libs/qt-assistant:4
	x11-libs/libX11
"
RDEPEND="${DEPEND}"

DOCS=(README)
