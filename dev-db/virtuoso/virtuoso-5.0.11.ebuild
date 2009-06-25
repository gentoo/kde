# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit base autotools flag-o-matic java-pkg-opt-2 multilib

MY_P="${PN}-opensource-${PV}"
DESCRIPTION="Virtuoso is a high-performance object-relational SQL database"
HOMEPAGE="http://virtuoso.openlinksw.com/wiki/main/Main/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug +imagemagick iodbc kerberos ldap mono perl php python readline
ruby wbxml"

DOCS="AUTHORS ChangeLog CREDITS INSTALL NEWS README"

# zeroconf support looks like broken - disabling
COMMON_DEPEND="
	dev-libs/libxml2:2
	>=dev-libs/openssl-0.9.7i:0
	sys-libs/zlib:0
	imagemagick? ( media-gfx/imagemagick:0 )
	iodbc? ( dev-db/libiodbc:0 )
	kerberos? ( app-crypt/mit-krb5 )
	ldap? ( net-nds/openldap )
	mono? ( dev-lang/mono )
	perl? ( dev-lang/perl )
	php? ( dev-lang/php:5 )
	python? ( dev-lang/python )
	readline? ( sys-libs/readline:0 )
	ruby? ( dev-lang/ruby )
	wbxml? ( dev-libs/libwbxml:0 )
"
DEPEND="${COMMON_DEPEND}
	>=sys-devel/bison-2.3
	>=sys-devel/flex-2.5.33
	java? ( >=virtual/jdk-1.6.0 )
"
RDEPEND="${COMMON_DEPEND}
	java? ( >=virtual/jre-1.6.0 )
"

PATCHES=(
	"${FILESDIR}/dist/${PV}-use-external-zlib.patch"
)

S="${WORKDIR}/${MY_P}"

src_prepare() {
	base_src_prepare
	java-pkg-opt-2_src_prepare
	eautoreconf
}

src_configure() {
	use amd64 && append-flags "-m64"

	local myconf=""

	# workaround random build failures
	MAKEOPTS="${MAKEOPTS} -j1"

	use java && myconf="--with-jdk4=$(java-config-2 -O)"

	econf \
		--with-layout=gentoo \
		--localstatedir=/var \
		--program-transform-name="s/isql/isql-v/" \
		$(use_with debug) \
		$(use_enable imagemagick) \
		$(use_with iodbc) \
		$(use_enable kerberos krb) \
		$(use_enable ldap openldap) \
		$(use_enable mono) \
		$(use_enable perl) \
		$(use_enable php php5 ) \
		$(use_enable python) \
		$(use_with readline) \
		$(use_enable ruby) \
		$(use_enable wbxml wbxml2) \
		--disable-rendezvous \
		--disable-hslookup \
		${myconf}
}

src_install() {
	base_src_install

	keepdir /var/lib/virtuoso/db
}

pkg_postinst() {
	echo
	einfo "To start the database server:"
	echo
	einfo "# cd /var/lib/virtuoso/db"
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
