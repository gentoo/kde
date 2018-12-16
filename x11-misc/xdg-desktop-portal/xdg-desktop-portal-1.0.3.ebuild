# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd

DESCRIPTION="Desktop integration portal"
HOMEPAGE="https://flatpak.org/ https://github.com/flatpak/xdg-desktop-portal"
SRC_URI="https://github.com/flatpak/${PN}/releases/download/${PV}/${P}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="
	dev-libs/glib:2[dbus]
	sys-fs/fuse
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-util/gdbus-codegen
	sys-devel/gettext
	virtual/pkgconfig
	doc? (
		app-text/xmlto
		app-text/docbook-xml-dtd:4.3
	)
"

src_configure() {
	local myeconfargs=(
		--disable-pipewire
		$(use_enable doc docbook-docs)
		--with-systemduserunitdir="$(systemd_get_userunitdir)"
	)
	econf "${myeconfargs[@]}"
}
