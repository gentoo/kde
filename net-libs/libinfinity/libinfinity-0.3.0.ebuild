# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

DESCRIPTION="An implementation of the Infinote protocol written in GObject-based C."
HOMEPAGE="http://gobby.0x539.de/"
SRC_URI="http://releases.0x539.de/${PN}/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="avahi doc gtk server"

RDEPEND=">=sys-libs/e2fsprogs-libs-1.41.4
	dev-libs/glib:2
	dev-libs/libxml2
	net-libs/gnutls
	>=net-misc/gsasl-0.2.21
	avahi? ( net-dns/avahi )
	gtk? ( >=x11-libs/gtk+-2.12:2 )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.23
	dev-util/gtk-doc"
#	doc? ( dev-util/gtk-doc )" bug 267545

pkg_setup() {
	if use server ; then
		enewgroup infinote 100
		enewuser infinote 100 /bin/bash /var/lib/infinote infinote
	fi
}

src_configure() {
	econf \
		$(use_enable doc gtk-doc) \
		$(use_with gtk inftextgtk) \
		$(use_with gtk infgtk) \
		$(use_with server infinoted) \
		$(use_with avahi)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS NEWS README TODO

	if use server ; then
		newinitd "${FILESDIR}/infinoted.initd-0.2" infinoted
		newconfd "${FILESDIR}/infinoted.confd-0.2" infinoted

		keepdir /var/lib/infinote
		fowners infinote:infinote /var/lib/infinote
		fperms 770 /var/lib/infinote

		elog "Add local users who should have local access to the documents"
		elog "created by infinoted to the infinote group."
		elog "The documents are saved in /var/lib/infinote per default."
	fi
}
