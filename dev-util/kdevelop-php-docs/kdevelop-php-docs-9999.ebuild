# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

KMNAME="kdevelop"
KDE_SCM="git"
ESCM_REPONAME="kdev-php-docs"
inherit kde4-base

DESCRIPTION="PHP documentation plugin for KDevelop 4"

KEYWORDS=""
LICENSE="GPL-2 LGPL-2"
IUSE="debug"

RDEPEND="
	!=dev-util/kdevelop-plugins-1.0.0
"
