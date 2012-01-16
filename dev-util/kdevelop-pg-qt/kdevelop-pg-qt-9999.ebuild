# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_SCM="git"
inherit kde4-base

DESCRIPTION="A LL(1) parser generator used mainly by KDevelop language plugins"
HOMEPAGE="http://www.kdevelop.org"

LICENSE="LGPL-2"
KEYWORDS=""
SLOT="0"
IUSE="debug"

RDEPEND=""
DEPEND="
	sys-devel/bison
	sys-devel/flex
"
