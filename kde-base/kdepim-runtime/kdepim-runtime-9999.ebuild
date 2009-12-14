# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdepim"
KMMODULE="runtime"
inherit kde4-meta

DESCRIPTION="KDE PIM runtime plugin collection"
KEYWORDS=""
IUSE="debug"

DEPEND="
	>=dev-libs/shared-desktop-ontologies-0.2
	$(add_kdebase_dep libkdepim)
"
RDEPEND="${DEPEND}"
