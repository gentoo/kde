# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_MINIMAL="4.6"

KDE_SCM="git"
EGIT_REPONAME="plasma-mobile"

inherit kde4-base

DESCRIPTION="Plasma mobile shell for internet tablets"
HOMEPAGE="http://kde.org/"

LICENSE="GPL-2 LGPL-2"
KEYWORDS=""
SLOT="4"
IUSE=""

DEPEND="
	$(add_kdebase_dep nepomuk)
	$(add_kdebase_dep plasma-workspace)
"
RDEPEND="${DEPEND}"

src_install() {
	kde4-base_src_install
	rm "${ED}/usr/share/apps/plasma/services/powermanagementservice.operations"	|| die
}
