# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebase-apps"
KMMODULE="plasma"
inherit kde4-meta

DESCRIPTION="Additional Applets for Plasma"
KEYWORDS=""
IUSE="debug htmlhandbook"

DEPEND="
	!kde-base/plasma:${SLOT}
	kde-base/libkonq:${SLOT}
"
RDEPEND="${DEPEND}"
