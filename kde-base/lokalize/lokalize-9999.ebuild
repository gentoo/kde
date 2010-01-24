# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdesdk"
inherit kde4-meta

DESCRIPTION="KDE4 translation tool"
KEYWORDS=""
IUSE="debug +handbook"

# Althrought they are purely runtime, its too useless without them
RDEPEND="
	$(add_kdebase_dep krosspython)
	$(add_kdebase_dep kdesdk-strigi-analyzer)
"
