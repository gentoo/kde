# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

KMNAME="kdevelop"
KDE_SCM="git"
ESCM_REPONAME="kdev-php"
inherit kde4-base

DESCRIPTION="PHP plugin for KDevelop 4"

KEYWORDS=""
LICENSE="GPL-2 LGPL-2"
IUSE="debug doc"

DEPEND="
	>=dev-util/kdevelop-pg-qt-0.9.0
"
RDEPEND="
	doc? ( >=dev-util/kdevelop-php-docs-${PV}:${SLOT} )
"
