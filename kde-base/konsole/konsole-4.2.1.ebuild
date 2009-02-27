# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/konsole/konsole-4.2.0.ebuild,v 1.2 2009/02/01 07:43:45 jmbsvicetto Exp $

EAPI="2"

KMNAME="kdebase"
KMMODULE="apps/${PN}"
inherit kde4-meta

DESCRIPTION="X terminal for use with KDE."
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug htmlhandbook"

COMMONDEPEND="
	x11-libs/libX11
	x11-libs/libXext
	>=x11-libs/libxklavier-3.2
	x11-libs/libXrender
	x11-libs/libXtst"
DEPEND="${COMMONDEPEND}
	x11-apps/bdftopcf
	x11-proto/kbproto
	x11-proto/renderproto"
RDEPEND="${COMMONDEPEND}"

src_unpack() {
	if use htmlhandbook; then
		KMEXTRA="${KMEXTRA}
			apps/doc/${PN}"
	fi

	kde4-meta_src_unpack
}
