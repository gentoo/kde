# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools eutils

SRC_URI="https://accounts-sso.googlecode.com/files/${PN}-1.16.tar.gz"
SLOT=0
DESCRIPTION="Accounts and SSO (Single Sign-On) framework for Linux and POSIX based platforms."
HOMEPAGE="https://01.org/gsso/"

LICENSE="LGPL-2.1"

KEYWORDS="~x86 ~amd64"

IUSE="debug"

DEPEND="
	dev-db/sqlite:3
	dev-libs/glib:2
	dev-libs/libxml2"

RDEPEND="$DEPEND"

S="${WORKDIR}/${PN}-1.16"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.16-to-1.18.patch
	eautoreconf
}

src_configure() {
	export HAVE_GCOV_FALSE='#'
	econf $(use_enable debug)
}
