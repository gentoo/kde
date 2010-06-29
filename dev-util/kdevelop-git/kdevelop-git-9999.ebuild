# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdevelop"
inherit kde4-base

DESCRIPTION="Git version control plugin for KDevelop 4"
EGIT_REPO_URI="git://gitorious.org/kdevelop4-git/kdevelop4-git.git"

LICENSE="|| ( GPL-2 GPL-3 )"
KEYWORDS=""
IUSE="debug"

DEPEND="
	>=dev-util/kdevelop-pg-qt-0.9.0
"
RDEPEND=""
