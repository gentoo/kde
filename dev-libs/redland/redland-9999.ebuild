# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/redland/redland-1.0.9-r2.ebuild,v 1.1 2009/12/11 19:49:18 ssuominen Exp $

EAPI=2

ESVN_REPO_URI="http://svn.librdf.org/repository/librdf/trunk"

if [[ ${PV} = *9999* ]]; then
	SVN_ECLASS="subversion"
else
	SVN_ECLASS=""
fi

inherit autotools ${SVN_ECLASS}

DESCRIPTION="High-level interface for the Resource Description Framework"
HOMEPAGE="http://librdf.org"

if [[ ${PV} = *9999* ]]; then
	RELEASE_URI=""
else
	RELEASE_URI="http://download.librdf.org/source/${P}.tar.gz"
fi

SRC_URI="${RELEASE_URI}"

LICENSE="LGPL-2.1 Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="berkdb mysql postgres sqlite ssl threads virtuoso xml"

RDEPEND="mysql? ( virtual/mysql )
	sqlite? ( =dev-db/sqlite-3* )
	berkdb? ( sys-libs/db )
	xml? ( dev-libs/libxml2 )
	!xml? ( dev-libs/expat )
	ssl? ( dev-libs/openssl )
	>=media-libs/raptor-1.4.20
	>=dev-libs/rasqal-0.9.16
	postgres? ( virtual/postgresql-base )
	virtuoso? ( dev-db/libiodbc )"
DEPEND="${RDEPEND}
	dev-util/gtk-doc
	dev-util/gtk-doc-am
	dev-util/pkgconfig
	>=sys-devel/libtool-2"

src_prepare() {
	if [[ ${PV} = *9999* ]]; then
		subversion_src_prepare

		sed -i -e '/SHAVE/d' configure.ac || die

		gtkdocize --copy

		eautoreconf
	fi
}

src_configure() {
	local myconf

	if use xml; then
		myconf="${myconf} --with-xml-parser=libxml"
	else
		myconf="${myconf} --with-xml-parser=expat"
	fi

	econf \
		--with-raptor=system \
		--with-rasqal=system \
		$(use_with berkdb bdb) \
		$(use_with ssl openssl-digests) \
		$(use_with mysql) \
		$(use_with threads) \
		$(use_with sqlite) \
		$(use_with postgres postgresql) \
		$(use_with virtuoso) \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die
}
