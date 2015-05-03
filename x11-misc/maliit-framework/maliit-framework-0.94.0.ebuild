# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qt4-r2
DESCRIPTION="A flexible and cross platform input method framework"
HOMEPAGE="http://maliit.org"
SRC_URI="http://pkgs.fedoraproject.org/repo/pkgs/${PN}/${P}.tar.bz2/fb60280410be256d49e3f2228db5f055/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+dbus doc examples gtk test"

DEPEND="
	dbus? (
		dev-libs/dbus-glib
		dev-libs/glib:2
		dev-qt/qtdbus:4
		sys-apps/dbus
	)
	gtk? (
		x11-libs/gtk+:2
		x11-libs/gtk+:3
		x11-libs/pango
	)
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	dev-qt/qtdeclarative:4
	virtual/libudev:=
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXfixes
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
