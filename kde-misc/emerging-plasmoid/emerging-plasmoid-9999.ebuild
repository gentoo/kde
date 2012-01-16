# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_SCM="git"
inherit kde4-base

DESCRIPTION="Portage emerge progress plasmoid based on app-portage/genlop"
HOMEPAGE="http://kde-apps.org/content/show.php/Emerging+Plasmoid?content=147414 "
EGIT_REPO_URI="git://github.com/leonardo2d/${PN}"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug"

DEPEND=""
RDEPEND="${DEPEND}
	app-portage/genlop
	$(add_kdebase_dep plasma-workspace)
"
