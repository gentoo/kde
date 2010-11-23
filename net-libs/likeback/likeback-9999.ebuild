# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit kde4-base git

DESCRIPTION="Likeback feedback lib"
HOMEPAGE="http://gitorious.org/~apachelogger/kmess/apacheloggers-likeback"
EGIT_REPO_URI="git://gitorious.org/~apachelogger/kmess/apacheloggers-likeback.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	>=kde-base/kdepimlibs-${KDE_MINIMAL}
"
RDEPEND="${DEPEND}"
