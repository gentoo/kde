# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_LINGUAS="ca ca@valencia da de en_GB es et fi fr gl it nb nds nl pl pt pt_BR
ru sv uk zh_CN zh_TW"
KMNAME="kdevelop"

if [[ $PV == *9999 ]]; then
	KDE_SCM="git"
	EGIT_REPONAME="kdev-php-docs"
	SRC_URI=""
	KEYWORDS=""
else
	KMMODULE="php-docs"
	KDEVELOP_VERSION="4.2.82"
	SRC_URI="mirror://kde/unstable/kdevelop/${KDEVELOP_VERSION}/src/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
fi

inherit kde4-base

DESCRIPTION="PHP documentation plugin for KDevelop 4"
LICENSE="GPL-2 LGPL-2"
IUSE="debug"

RDEPEND="
	!=dev-util/kdevelop-plugins-1.0.0
"
