# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Library to use KDE's StatusNotifierItem via GObject"
HOMEPAGE="https://github.com/jjk-jacky/statusnotifier"
SRC_URI="https://github.com/jjk-jacky/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples"

BDEPEND="dev-util/gtk-doc"
DEPEND="dev-libs/glib:2
	x11-libs/gdk-pixbuf:2
	x11-libs/cairo
	examples? ( x11-libs/gtk+:3 )"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
	eapply_user
}

src_configure() {
	econf $(use_enable examples example)
}
