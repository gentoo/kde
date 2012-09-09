# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_MINIMAL="4.6"
inherit kde4-base

DESCRIPTION="Plasma mobile shell for internet tablets"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2 LGPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep nepomuk)
	$(add_kdebase_dep plasma-workspace)
"
RDEPEND="${DEPEND}"
