# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit kde4-base

DESCRIPTION="Portage emerge progress plasmoid"
HOMEPAGE="http://kde-apps.org/content/show.php/Emerging+Plasmoid?content=147414 "
EGIT_REPO_URI="git://github.com/mobius3/${PN}"

LICENSE="GPL-3"
KEYWORDS=""
SLOT="4"
IUSE="debug"

DEPEND="
	dev-lang/perl
	dev-perl/DateManip
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep plasma-workspace)
"
