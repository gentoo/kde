# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit cmake-utils subversion

DESCRIPTION="Lightweight C++ template library for vector and matrix math, a.k.a. linear algebra"
HOMEPAGE="http://eigen.tuxfamily.org/"
ESVN_REPO_URI="svn://anonsvn.kde.org/home/kde/trunk/kdesupport/eigen2"

LICENSE="GPL-3"
SLOT="2"
KEYWORDS=""
IUSE="debug"

RDEPEND="
	!dev-cpp/eigen:0
"
