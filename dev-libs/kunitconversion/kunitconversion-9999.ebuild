# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdereview"
KMNOMODULE="true"
inherit kde4-meta

DESCRIPTION="Unit conversion library for KDE apps"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS=""
IUSE="debug"

RDEPEND="
	!dev-libs/conversion
"

KMEXTRA="kunitconversion/"
