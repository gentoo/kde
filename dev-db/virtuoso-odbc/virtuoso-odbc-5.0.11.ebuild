# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

#inherit virtuoso java-pkg-opt-2
inherit virtuoso

DESCRIPTION="ODBC driver for OpenLink Virtuoso"

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

#DEPEND="
#	java? ( >=virtual/jdk-1.6.0 )
#"
#RDEPEND="
	#java? ( >=virtual/jre-1.6.0 )
#"

#pkg_setup() {
#	use java && VOS_EXTRACT="libsrc/JDBCDriverType4 ${VOS_EXTRACT}"
#}

#src_prepare() {
#	java-pkg-opt-2_src_prepare
#	virtuoso_src_prepare
#}

#src_configure() {
#	use java && myconf="${myconf} --with-jdk4=$(java-config-2 -O)"
#}
