# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

KDE_SCM="git"
inherit kde4-base

DESCRIPTION="Likeback feedback lib"
HOMEPAGE="http://gitorious.org/~apachelogger/kmess/apacheloggers-likeback"
ESCM_REPO_URI="git://gitorious.org/~apachelogger/kmess/apacheloggers-likeback.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	>=kde-base/kdelibs-${KDE_MINIMAL}
"
RDEPEND="${DEPEND}"
