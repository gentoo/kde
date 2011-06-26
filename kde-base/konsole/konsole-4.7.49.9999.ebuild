# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_HANDBOOK="optional"
KDE_SCM="git"

if [[ ${PV} = *9999 ]]; then
	KDE_DOC_DIRS="doc/manual"
	kde_eclass="kde4-base"
else
	KMNAME="kde-baseapps"
	kde_eclass="kde4-meta"
fi
inherit ${kde_eclass}

DESCRIPTION="X terminal for use with KDE."
KEYWORDS=""
IUSE="debug"

COMMONDEPEND="
	!aqua? (
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

PATCHES=( "${FILESDIR}/${PN}-4.6.4-imagesize.patch" )
