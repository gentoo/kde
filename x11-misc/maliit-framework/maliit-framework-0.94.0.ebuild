# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qt4-r2
DESCRIPTION="A flexible and cross platform input method framework"
HOMEPAGE="http://maliit.org"
SRC_URI="http://maliit.org/releases/${PN}/${PF}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+dbus doc examples gtk test"

DEPEND="
	dbus? ( sys-apps/dbus )
	gtk? ( x11-libs/gtk+ )
	dev-qt/qtdeclarative
"

RDEPEND="${DEPEND}"

RESTRICT="test"

PATCHES=( "${FILESDIR}/${PN}-0.94.0-removeldconfig.patch" )

DOCS=( README )

src_prepare() {
	use !examples && sed -i -e 's:SUBDIRS += examples::' maliit-framework.pro
	qt4-r2_src_prepare
}

src_configure() {
	local myconf="nostrip"
	use !dbus && myconf="${myconf} disable-dbus"
	use !doc && myconf="${myconf} nodoc"
	use !gtk && myconf="${myconf} nogtk"
	use !test && myconf="${myconf} notests"
	qmake PREFIX="${EPREFIX}/usr" CONFIG+="${myconf}"
}
