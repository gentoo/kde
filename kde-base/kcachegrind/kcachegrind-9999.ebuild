# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdesdk
inherit kde4svn-meta

DESCRIPTION="KDE Frontend for Cachegrind"
KEYWORDS=""
IUSE="debug htmlhandbook"

RDEPEND="${RDEPEND} media-gfx/graphviz"
