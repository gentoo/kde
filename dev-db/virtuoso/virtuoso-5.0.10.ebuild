# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

inherit base eutils flag-o-matic java-pkg-opt-2 multilib

DESCRIPTION="Virtuoso is a high-performance object-relational SQL database"
HOMEPAGE="http://virtuoso.openlinksw.com/wiki/main/Main/"
SRC_URI="mirror://sourceforge/virtuoso/virtuoso-opensource-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug +imagemagick kerberos ldap mono perl php python readline ruby
wbxml"

DOCS="AUTHORS ChangeLog CREDITS INSTALL NEWS README"

# zeroconf support looks like broken - disabled
RDEPEND="
	dev-libs/libxml2
	>=dev-libs/openssl-0.9.7i
	imagemagick? ( media-gfx/imagemagick )
	java? ( virtual/jdk:1.6 )
	kerberos? ( app-crypt/mit-krb5 )
	ldap? ( net-nds/openldap )
	mono? ( dev-lang/mono )
	perl? ( dev-lang/perl )
	php? ( dev-lang/php:5 )
	python? ( dev-lang/python )
	readline? ( sys-libs/readline )
	ruby? ( dev-lang/ruby )
	wbxml? ( dev-libs/libwbxml )
"
DEPEND="${RDEPEND}
	>=sys-devel/bison-2.3
	>=sys-devel/flex-2.5.33
"

S="${WORKDIR}/virtuoso-opensource-${PV}"

src_compile() {
	use amd64 && append-flags "-m64"

	local myconf=""

	use java && myconf="--with-jdk4=$(java-config-2 -O)"

	econf \
		--with-layout=gentoo \
		--localstatedir=/var \
		--program-transform-name="s/isql/isql-v/" \
		$(use_enable debug) \
		$(use_enable imagemagick) \
		$(use_enable kerberos krb) \
		$(use_enable ldap openldap) \
		$(use_enable mono) \
		$(use_enable perl) \
		$(use_enable php php5 ) \
		$(use_enable python) \
		$(use_with readline ) \
		$(use_enable ruby) \
		$(use_enable wbxml wbxml2) \
		--disable-rendezvous \
		--disable-hslookup \
		${myconf} \
		|| die "configure failed"

	# -j1: avoid weird random flex errors
	emake -j1 || die
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
