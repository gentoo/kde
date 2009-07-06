# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit virtuoso

DESCRIPTION="ODBC driver for OpenLink Virtuoso Open-Source Edition"

KEYWORDS="~amd64 ~x86"
IUSE="+iodbc static-libs"

RDEPEND="
	>=dev-libs/openssl-0.9.7i:0
"
DEPEND="${RDEPEND}
	iodbc? ( dev-db/libiodbc:0 )
"

VOS_EXTRACT="
	libsrc/Dk
	libsrc/Thread
	libsrc/util
	binsrc/driver
"

pkg_setup() {
	use iodbc || VOS_EXTRACT="libsrc/odbcsdk ${VOS_EXTRACT}"
}

src_configure() {
	myconf="${myconf}
		$(use_with iodbc)
		$(use_enable static-libs static)"

	virtuoso_src_configure
}

src_install() {
	virtuoso_src_install

	# Remove libtool files
	if ! use static-libs; then
		local libdir
		for libdir in $(get_all_libdirs); do
			rm -f "${D}/${ROOT}usr/${libdir}"/*.la || die
		done
	fi
}
