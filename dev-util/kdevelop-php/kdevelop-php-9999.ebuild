# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KMNAME="kdevelop"

if [[ $PV == *9999 ]]; then
	KDE_SCM="git"
	EGIT_REPONAME="kdev-php"
	KEYWORDS=""
	SRC_URI=""
else
	KMMODULE="php"
	KDEVELOP_VERSION="4.2.82"
	SRC_URI="mirror://kde/unstable/kdevelop/${KDEVELOP_VERSION}/src/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
fi

inherit kde4-base

DESCRIPTION="PHP plugin for KDevelop 4"

LICENSE="GPL-2 LGPL-2"
IUSE="debug doc"

DEPEND="
	>=dev-util/kdevelop-pg-qt-0.9.82
"
RDEPEND="
	dev-util/kdevelop
	doc? ( >=dev-util/kdevelop-php-docs-${PV}:${SLOT} )
"
