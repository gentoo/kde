# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdepim"
KMMODULE="knotes"

inherit kde4-meta

DESCRIPTION="KDE Notes application"
KEYWORDS=""
IUSE="debug"

DEPEND=">=kde-base/libkdepim-${PV}[kdeprefix=]"
RDEPEND="${DEPEND}"
