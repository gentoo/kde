# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit kde4-base

DESCRIPTION="The Nepomuk Swiss Army Knife aka. NepomukShell allows to browse, query, and edit Nepomuk resources"
HOMEPAGE="https://projects.kde.org/projects/extragear/utils/nepomukshell"
SRC_URI="http://ftp.kde.org/unstable/nepomuk/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep nepomuk)
"

RDEPEND="
	dev-vcs/git
	${DEPEND}
"
