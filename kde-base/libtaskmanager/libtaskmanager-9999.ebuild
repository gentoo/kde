# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebase-workspace"
KMMODULE="libs/taskmanager"
inherit kde4-meta

DESCRIPTION="A library that provides basic taskmanager functionality"
KEYWORDS=""
IUSE="debug xcomposite"

COMMONDEPEND="
	>=kde-base/kephal-${PV}:${SLOT}[kdeprefix=]
	x11-libs/libXfixes
	x11-libs/libXrender
	xcomposite? ( x11-libs/libXcomposite )
"
DEPEND="${COMMONDEPEND}
	x11-proto/renderproto
	xcomposite? ( x11-proto/compositeproto )
"
RDEPEND="${COMMONDEPEND}"

KMSAVELIBS="true"
