# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

KDE_HANDBOOK="optional"
KMNAME="kdegraphics"
inherit kde4-meta

DESCRIPTION="A screen ruler for the K Desktop Environment"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

# Fix for the install dir of the handbook
PATCHES=( "${FILESDIR}/${P}-fix-handbook.patch" )
