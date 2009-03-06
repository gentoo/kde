# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebase-apps"
inherit kde4-meta

DESCRIPTION="Netscape plugins support for Konqueror."
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

DEPEND="
	x11-libs/libXt
	x11-libs/qt-gui:4[glib]
"
RDEPEND="${DEPEND}
	>=kde-base/konqueror-${PV}:${SLOT}[kdeprefix=]
"

KMEXTRACTONLY="
	konqueror/settings/
"
