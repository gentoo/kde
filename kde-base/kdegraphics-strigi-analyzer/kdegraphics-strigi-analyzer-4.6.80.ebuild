# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

KDE_SCM="git"
inherit kde4-base

DESCRIPTION="kdegraphics: strigi plugins"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

if [[ ${PV} != *9999 ]]; then
KMEXTRACTONLY="
	libs/mobipocket/
"
fi

DEPEND="
	app-misc/strigi
"
RDEPEND="${DEPEND}"
