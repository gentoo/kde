# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

KMNAME="kdebase-workspace"
KMMODULE="libs/plasmagenericshell"
inherit kde4-meta

DESCRIPTION="Libraries for the KDE Plasma shell"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep libkworkspace)
"

KMSAVELIBS="true"
