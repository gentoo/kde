# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit virtuoso

DESCRIPTION="Server binaries for Virtuoso, high-performance object-relational SQL database"

KEYWORDS="~amd64 ~x86"
IUSE="+iodbc kerberos ldap readline static-libs"

# zeroconf support looks like broken - disabling
# mono support fetches mono source and compiles it manually - disabling for now
# mono? ( dev-lang/mono )
COMMON_DEPEND="
	dev-libs/libxml2:2
	>=dev-libs/openssl-0.9.7i:0
	sys-libs/zlib:0
	iodbc? ( dev-db/libiodbc:0 )
	kerberos? ( app-crypt/mit-krb5 )
	ldap? ( net-nds/openldap )
	readline? ( sys-libs/readline:0 )
"
DEPEND="${COMMON_DEPEND}
	>=sys-devel/bison-2.3
	>=sys-devel/flex-2.5.33
"
RDEPEND="${COMMON_DEPEND}
	>=dev-db/virtuoso-odbc-${PV}:${SLOT}
"

VOS_EXTRACT="
	libsrc/Dk
	libsrc/Thread
	libsrc/Tidy
	libsrc/Wi
	libsrc/Xml.new
	libsrc/langfunc
	libsrc/plugin
	libsrc/util
	binsrc/virtuoso
	binsrc/tests
"

pkg_setup() {
	use iodbc || VOS_EXTRACT="libsrc/odbcsdk ${VOS_EXTRACT}"
}

src_prepare() {
	if ! use static-libs; then
		sed -e '/^lib_LTLIBRARIES\s*=.*/s/lib_/noinst_/' -i binsrc/virtuoso/Makefile.am \
			|| die "failed to disable installation of static lib"
	fi

	virtuoso_src_prepare
}

src_configure() {
	myconf="${myconf}
		$(use_with iodbc)
		$(use_enable kerberos krb)
		$(use_enable ldap openldap)
		$(use_with readline)
		$(use_enable static-libs static)
		--disable-rendezvous
		--disable-hslookup"

	virtuoso_src_configure
}

src_install() {
	virtuoso_src_install

	# The only difference between binaries is using bundled vs external iODBC
	# We prefer external ones.
	if use iodbc; then
		mv "${D}/${ROOT}usr/bin/virtuoso-iodbc-t" "${D}/${ROOT}usr/bin/virtuoso-t" || die
		mv "${D}/${ROOT}usr/bin/isql-iodbc" "${D}/${ROOT}usr/bin/isql" || die
		mv "${D}/${ROOT}usr/bin/isqlw-iodbc" "${D}/${ROOT}usr/bin/isqlw" || die
	fi

	# Rename isql executables (conflicts with unixODBC)
	mv "${D}/${ROOT}usr/bin/isql" "${D}/${ROOT}usr/bin/isql-v" || die
	mv "${D}/${ROOT}usr/bin/isqlw" "${D}/${ROOT}usr/bin/isqlw-v" || die

	dodoc AUTHORS ChangeLog CREDITS INSTALL NEWS README || die

	keepdir "${ROOT}var/lib/virtuoso/db"
}

pkg_postinst() {
	echo
	einfo "To start the database server:"
	echo
	einfo "# cd ${ROOT}var/lib/virtuoso/db"
	einfo "# virtuoso-t -f &"
	echo
	einfo "Then you should be able to access http://localhost:8890/"
	einfo "and the conductor VAD at http://localhost:8890/conductor/."
	einfo "The default login is dba:dba"
	echo
	einfo "The command line interface can be accessed with"
	echo
	einfo "$ isql-v 1111 dba dba"
	echo
}
