# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base git

DESCRIPTION="Yet another menu for KDE4"
HOMEPAGE="http://raptor-menu.org/"
EGIT_REPO_URI="git://github.com/ruphy/raptor.git"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="0"
IUSE="debug"

src_unpack() {
	git_src_unpack
}
