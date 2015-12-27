# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit kde4-base

DESCRIPTION="Git commit integration in Akonadi"
HOMEPAGE="https://projects.kde.org/projects/playground/pim/akonadi-git-resource"
LICENSE="GPL-2"

SLOT="4"
KEYWORDS=""
IUSE="debug"

DEPEND="
	$(add_kdeapps_dep kdepimlibs)
	>=dev-libs/libgit2-0.17:=
"
