# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDEBASE="kdevelop"
KMNAME="kdev-mercurial"
inherit kde4-base

DESCRIPTION="Mercurial plugin for KDevelop 4"
LICENSE="GPL-3"
KEYWORDS=""
IUSE="debug"

RDEPEND="
	dev-vcs/mercurial
"
