# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit cmake-utils 

DESCRIPTION="Little CMS ICC profile construction set"
HOMEPAGE="http://lprof.sourceforge.net/"
SRC_URI="http://dev.gentooexperimental.org/~tampakrap/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="x11-libs/qt-core:4[qt3support]
	x11-libs/qt-assistant:4
	dev-libs/openssl
	sys-libs/zlib
	media-libs/libpng
	media-libs/tiff
	media-libs/jpeg
	media-libs/vigra
	virtual/libusb
	x11-libs/libX11
	"
RDEPEND="${DEPEND}"

DOCS="README"