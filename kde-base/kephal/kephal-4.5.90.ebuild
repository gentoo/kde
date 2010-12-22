# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

KMNAME="kdebase-workspace"
KMMODULE="libs/kephal"
inherit kde4-meta

DESCRIPTION="Allows handling of multihead systems via the XRandR extension"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="
	x11-libs/libXrandr
"
DEPEND="${RDEPEND}
	x11-proto/randrproto
"
