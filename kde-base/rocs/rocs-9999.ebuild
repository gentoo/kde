# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

KDE_HANDBOOK="optional"
if [[ ${PV} == *9999 ]]; then
	KDE_SCM="git"
	inherit kde4-base
else
	KMNAME="kdeedu"
	inherit kde4-meta
fi

DESCRIPTION="KDE4 interface to work with Graph Theory"
KEYWORDS=""
IUSE="debug"

DEPEND="
	>=dev-cpp/eigen-2.0.3:2
"
RDEPEND=""
