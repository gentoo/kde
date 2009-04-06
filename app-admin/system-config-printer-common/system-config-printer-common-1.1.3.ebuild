# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit python autotools

MY_P="${PN%-common}-${PV}"

DESCRIPTION="Common modules of Red Hat's printer administration tool"
HOMEPAGE="http://cyberelk.net/tim/software/system-config-printer/"
SRC_URI="http://cyberelk.net/tim/data/system-config-printer/1.1/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

# system-config-printer split since 1.1.3
RDEPEND="
	!app-admin/system-config-printer:0
	dev-libs/libxml2[python]
	dev-python/dbus-python
	dev-python/pycups
	dev-python/pygobject
	net-print/cups[dbus]
"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-1.1.3-split.patch"

	eaclocal
	eautomake
	eautoconf
}

src_configure() {
	econf --disable-nls || die "econf failed"
}

src_install() {
	dodoc AUTHORS ChangeLog README || die "dodoc failed"

	emake DESTDIR="${D}" install || die "emake install failed"
}
