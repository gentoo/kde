# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit kde4-base

DESCRIPTION="Declarative plasmoids for the plasma desktop and mobile"
HOMEPAGE="https://projects.kde.org/projects/playground/base/declarative-plasmoids"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS=""
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kdelibs)
"

RDEPEND="
	${DEPEND}
"
