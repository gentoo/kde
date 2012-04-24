# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit kde4-base

DESCRIPTION="Portage emerge progress plasmoid"
HOMEPAGE="http://kde-apps.org/content/show.php/Emerging+Plasmoid?content=147414 "
SRC_URI="mirror://github/leonardo2d/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

DEPEND=""
RDEPEND="${DEPEND}
	$(add_kdebase_dep plasma-workspace)
"
