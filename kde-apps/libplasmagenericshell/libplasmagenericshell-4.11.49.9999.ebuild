# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DECLARATIVE_REQUIRED="always"
KMNAME="kde-workspace"
KMMODULE="libs/plasmagenericshell"
inherit kde4-meta

DESCRIPTION="Libraries for the KDE Plasma shell"
KEYWORDS=""
IUSE="debug test"

DEPEND="
	$(add_kdebase_dep kephal)
	$(add_kdebase_dep libkworkspace)
	x11-libs/libX11
"
RDEPEND="${DEPEND}"

KMSAVELIBS="true"

KMEXTRACTONLY="
	libs/kephal/kephal/
	plasma/desktop/shell/data/
"
