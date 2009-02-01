# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebase-apps"
inherit kde4-meta

DESCRIPTION="Netscape plugins support for Konqueror."
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	>=kde-base/konqueror-${PV}:${SLOT}
	x11-libs/libXt"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	konqueror/settings/
"
