# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils autotools
DESCRIPTION="The intelligent predictive text entry system"
HOMEPAGE="http://http://presage.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples gtk python sqlite test"

RDEPEND="
	app-text/dos2unix
	examples? ( sys-libs/ncurses )
	gtk? ( x11-libs/gtk+ )
	python? ( dev-lang/python dev-python/dbus-python )
	sqlite? ( dev-db/sqlite )
"

DEPEND="${RDEPEND}
	sys-apps/help2man
	doc? ( app-doc/doxygen )
	python? ( dev-lang/swig )
	test? ( dev-util/cppunit )
"

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.8.8-automagic.patch"
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		$(use_enable doc documentation)
		$(use_enable examples curses)
		$(use_enable gtk gpresagemate)
		$(use_enable gtk gprompter)
		$(use_enable python)
		$(use_enable python python-binding)
		$(use_enable sqlite)
		$(use_enable test)
	)
	econf ${myeconfargs}
}
