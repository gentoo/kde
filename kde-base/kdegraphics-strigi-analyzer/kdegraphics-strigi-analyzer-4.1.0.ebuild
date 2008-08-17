# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdegraphics
KMMODULE=strigi-analyzer
inherit kde4-meta

DESCRIPTION="kdegraphics: strigi plugins"
KEYWORDS="~amd64"
IUSE="debug"

DEPEND=">=app-misc/strigi-0.5.10"
RDEPEND="${DEPEND}"
