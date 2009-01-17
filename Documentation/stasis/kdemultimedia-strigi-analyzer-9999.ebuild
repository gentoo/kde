# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="1"

KMNAME=kdemultimedia
KMMODULE=strigi-analyzer
inherit kde4svn-meta

DESCRIPTION="kdemultimedia: strigi plugins"
KEYWORDS=""
IUSE="debug"

DEPEND=">=app-misc/strigi-0.5.10"
RDEPEND="${DEPEND}"
