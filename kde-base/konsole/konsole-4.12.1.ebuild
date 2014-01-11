# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
KDE_DOC_DIRS="doc/manual"
VIRTUALX_REQUIRED="test"
VIRTUALDBUS_TEST="true"
inherit kde4-base

DESCRIPTION="X terminal for use with KDE"
HOMEPAGE="http://www.kde.org/applications/system/konsole http://konsole.kde.org"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

COMMONDEPEND="
	!aqua? (
		$(add_kdebase_dep libkonq)
		x11-libs/libX11
		x11-libs/libXext
		>=x11-libs/libxklavier-3.2
		x11-libs/libXrender
		x11-libs/libXtst
	)
"
DEPEND="${COMMONDEPEND}
	!aqua? (
		x11-apps/bdftopcf
		x11-proto/kbproto
		x11-proto/renderproto
	)
"
RDEPEND="${COMMONDEPEND}"
