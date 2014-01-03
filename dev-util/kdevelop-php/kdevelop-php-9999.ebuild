# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_LINGUAS="ca ca@valencia da de el en_GB es et fi fr gl it nb nds nl pl pt
pt_BR sv th uk zh_CN zh_TW"
VIRTUALX_REQUIRED=test
KDEBASE="kdevelop"
KMNAME="kdev-php"
EGIT_REPONAME="${KMNAME}"

inherit kde4-base

DESCRIPTION="PHP plugin for KDevelop 4"
LICENSE="GPL-2 LGPL-2"
IUSE="debug doc"

if [[ $PV != *9999* ]]; then
	KEYWORDS="~amd64 ~x86"
else
	KEYWORDS=""
fi

DEPEND="
	>=dev-util/kdevelop-pg-qt-1.0.0
"
RDEPEND="
	dev-util/kdevelop
	doc? ( >=dev-util/kdevelop-php-docs-${PV}:${SLOT} )
"
PATCHES=( "${FILESDIR}/${PN}"-1.2.0-parmake.patch )
