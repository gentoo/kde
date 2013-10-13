# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils git-r3

DESCRIPTION="Official GTK+ port of KDE's Oxygen widget style"
HOMEPAGE="https://projects.kde.org/projects/playground/artwork/oxygen-gtk"
EGIT_REPO_URI=( "git://anongit.kde.org/oxygen-gtk" )

LICENSE="LGPL-2.1"
KEYWORDS=""
SLOT="0"
IUSE="debug doc"

RDEPEND="
	dev-libs/glib
	x11-libs/cairo
	x11-libs/gtk+:2
	x11-libs/libX11
	x11-libs/pango
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( app-doc/doxygen )
"

DOCS=(AUTHORS README)

src_install() {
	if use doc; then
		{ cd "${S}" && doxygen Doxyfile; } || die "Generating documentation failed"
		HTML_DOCS=( "${S}/doc/html/" )
	fi

	cmake-utils_src_install

	cat <<-EOF > 99oxygen-gtk
CONFIG_PROTECT="/usr/share/themes/oxygen-gtk/gtk-2.0"
EOF
	doenvd 99oxygen-gtk
}
