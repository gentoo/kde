# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

FRAMEWORKS_TYPE="tier2"
FRAMEWORKS_DOXYGEN="true"
inherit kde-frameworks

DESCRIPTION="Gettext-based translation framework"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

RDEPEND="
	$(add_frameworks_dep kjs)
"
DEPEND="${RDEPEND}
	dev-lang/perl
"
