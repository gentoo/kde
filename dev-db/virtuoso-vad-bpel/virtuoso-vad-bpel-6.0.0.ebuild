# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit virtuoso

DESCRIPTION="TODO"

KEYWORDS="~amd64"
IUSE=""

VOS_EXTRACT="
	binsrc/bpel
"

RDEPEND="
	>=dev-db/virtuoso-server-${PV}:${SLOT}
"
