# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KMNAME="kde-workspace"
KMMODULE="libs/oxygen"
inherit kde4-meta

DESCRIPTION="Library to support the Oxygen style in KDE"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

PATCHES=( "${FILESDIR}/${PN}-4.7.4-enablefinal.patch" )
