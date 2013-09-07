# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/virtuoso-odbc/virtuoso-odbc-6.1.6.ebuild,v 1.5 2013/04/26 00:48:51 creffett Exp $

EAPI=5

inherit virtuoso

DESCRIPTION="ODBC driver for OpenLink Virtuoso Open-Source Edition"

#Upstream says no 32-bit (yet), https://github.com/openlink/virtuoso-opensource/issues/69
KEYWORDS="~amd64 -x86"
IUSE=""

RDEPEND="
	>=dev-libs/openssl-0.9.7i:0
"
DEPEND="${RDEPEND}"

VOS_EXTRACT="
	libsrc/Dk
	libsrc/Thread
	libsrc/odbcsdk
	libsrc/util
	binsrc/driver
"

src_configure() {
	myconf+="
		--disable-static
		--without-iodbc
	"

	virtuoso_src_configure
}

src_install() {
	virtuoso_src_install

	# Remove libtool files
	find "${ED}" -name '*.la' -delete
}
