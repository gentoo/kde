# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdegames
inherit kde4-meta

DESCRIPTION="Skat game for KDE"
KEYWORDS="~amd64"
IUSE="debug "

PATCHES="${FILESDIR}/${PN}-4.0.0-link.patch"

