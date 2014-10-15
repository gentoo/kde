# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools

DESCRIPTION="Library to use KDE's StatusNotifierItem via GObject"
HOMEPAGE="https://github.com/jjk-jacky/statusnotifier"
SRC_URI="https://github.com/jjk-jacky/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc examples"

RDEPEND="dev-libs/glib:2
	x11-libs/gdk-pixbuf
	examples? ( x11-libs/gtk+:3 )"
DEPEND="${RDEPEND}
	dev-util/gtk-doc"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf $(use_enable examples example)
}
