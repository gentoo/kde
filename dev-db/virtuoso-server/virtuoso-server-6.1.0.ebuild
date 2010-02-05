# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit virtuoso

DESCRIPTION="Server binaries for Virtuoso, high-performance object-relational SQL database"

KEYWORDS="~amd64 ~x86"
IUSE="kerberos ldap readline static-libs"

# zeroconf support looks like broken - disabling
# mono support fetches mono source and compiles it manually - disabling for now
# mono? ( dev-lang/mono )
COMMON_DEPEND="
	dev-libs/libxml2:2
	>=dev-libs/openssl-0.9.7i:0
	sys-libs/zlib:0
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
	libsrc/odbcsdk
	libsrc/plugin
	libsrc/util
	binsrc/virtuoso
	binsrc/tests
"

pkg_setup() {
	if has_version '<dev-db/virtuoso-server-6.0.0' && has_version 'kde-base/nepomuk'; then
		VIRTUOSO_UPGRADE=1
	fi
}

src_prepare() {
	if ! use static-libs; then
		sed -e '/^lib_LTLIBRARIES\s*=.*/s/lib_/noinst_/' -i binsrc/virtuoso/Makefile.am \
			|| die "failed to disable installation of static lib"
	fi

	virtuoso_src_prepare
}

src_configure() {
	myconf+="
		$(use_enable kerberos krb)
		$(use_enable ldap openldap)
		$(use_with readline)
		$(use_enable static-libs static)
		--disable-rendezvous
		--disable-hslookup
		--without-iodbc
	"

	virtuoso_src_configure
}

src_install() {
	use prefix || ED="${D}"

	virtuoso_src_install

	# Rename isql executables (conflicts with unixODBC)
	mv "${ED}/usr/bin/isql" "${ED}/usr/bin/isql-v" || die
	mv "${ED}/usr/bin/isqlw" "${ED}/usr/bin/isqlw-v" || die

	dodoc AUTHORS ChangeLog CREDITS INSTALL NEWS README || die "dodoc failed"

	keepdir /var/lib/virtuoso/db
}

pkg_postinst() {
	if [[ -n ${VIRTUOSO_UPGRADE} ]]; then
		echo
		ewarn "You're upgrading from Virtuoso V5. Note that your existing Nepomuk Virtuoso databases"
		ewarn "will not work with Virtuoso V6 release unless you do one of the following:"
		ewarn "a) Remove existing databases:"
		ewarn "  (as user) $ rm -r \${HOME}/.kde4/share/apps/nepomuk/repository"
		ewarn "b) Try to convert existing databases to V6 format:"
		ewarn "  (as root) # emerge -1 dev-db/virtuosoconverter"
		ewarn "  (as user) $ virtuosoconverter --auto"
		ewarn "  (as root) # emerge -C virtuosoconverter"
		echo
	fi
}
