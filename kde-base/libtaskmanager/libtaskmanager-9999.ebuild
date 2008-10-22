# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdebase-workspace
KMMODULE=libs/taskmanager
inherit kde4svn-meta

DESCRIPTION="A library that provides basic taskmanager functionality"
KEYWORDS=""
IUSE="debug xcomposite"

RDEPEND="x11-libs/libXfixes
	x11-libs/libXrender
	xcomposite? ( x11-libs/libXcomposite )"
DEPEND="${RDEPEND}
	x11-proto/renderproto
	xcomposite? ( x11-proto/compositeproto )"
