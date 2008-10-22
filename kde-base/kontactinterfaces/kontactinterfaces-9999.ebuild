# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdepim
inherit kde4svn-meta

DESCRIPTION="Interfaces for Kontact"
KEYWORDS=""
IUSE="debug"

KMEXTRACTONLY="libkdepim/"
KMSAVELIBS="true"

DEPEND="kde-base/libkdepim:${SLOT}"
