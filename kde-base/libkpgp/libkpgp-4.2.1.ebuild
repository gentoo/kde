# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="KDE pgp abstraction library"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

PATCHES=( "${FILESDIR}/${PN}-4.1.72-fix.patch" )
