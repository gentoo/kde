# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Library to use KDE's StatusNotifierItem via GObject"
HOMEPAGE="https://github.com/jjk-jacky/statusnotifier"
SRC_URI="https://github.com/jjk-jacky/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="dbus examples introspection"

BDEPEND="dev-util/gtk-doc"
DEPEND="
	dev-libs/glib:2
	x11-libs/gdk-pixbuf:2
	x11-libs/cairo
	dbus? (
		dev-libs/libdbusmenu[gtk3]
		x11-libs/gtk+:3
	)
	examples? ( x11-libs/gtk+:3 )
	introspection? ( dev-libs/gobject-introspection )
"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myeconfargs=(
		--disable-static
		$(use_enable dbus dbusmenu)
		$(use_enable introspection)
		$(use_enable examples example)
	)
	econf "${myeconfargs[@]}"
}

src_install() {
	default
	find "${D}" -name '*.la' -delete || die
}
