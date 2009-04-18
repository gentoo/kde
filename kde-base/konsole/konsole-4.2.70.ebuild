# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebase-apps"
inherit kde4-meta

DESCRIPTION="X terminal for use with KDE."
KEYWORDS="~amd64 ~x86"
IUSE="debug doc"

COMMONDEPEND="
	x11-libs/libX11
	x11-libs/libXext
	>=x11-libs/libxklavier-3.2
	x11-libs/libXrender
	x11-libs/libXtst
"
DEPEND="${COMMONDEPEND}
	x11-apps/bdftopcf
	x11-proto/kbproto
	x11-proto/renderproto
"
RDEPEND="${COMMONDEPEND}"
