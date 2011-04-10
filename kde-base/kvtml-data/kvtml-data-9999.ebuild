# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

if [[ ${PV} == *9999 ]]; then
	KDE_SCM="git"
	inherit kde4-base
else
	KMNAME="kdeedu"
	KMMODULE="data"
	inherit kde4-meta
fi

DESCRIPTION="Kvtml data for various KDE games"
KEYWORDS=""
IUSE=""
