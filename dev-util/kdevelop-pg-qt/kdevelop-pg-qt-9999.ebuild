# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit git kde4-base

DESCRIPTION="A LL(1) parser generator used mainly by KDevelop language plugins"
HOMEPAGE="http://www.kdevelop.org"
EGIT_REPO_URI="git://anongit.kde.org/kdevelop-pg-qt"

LICENSE="LGPL-2"
KEYWORDS=""
SLOT="0"
IUSE="debug"

RDEPEND=""
DEPEND="
	sys-devel/bison
	sys-devel/flex
"

src_unpack() {
	git_src_unpack
}
