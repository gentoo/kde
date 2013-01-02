# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KMNAME="kdeartwork"
KDE_SCM="svn"
KMMODULE="ColorSchemes"
inherit kde4-meta

DESCRIPTION="KDE extra colorschemes"
KEYWORDS="~amd64 ~arm ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE=""

# Moved here in 4.7
add_blocker kdeaccessibility-colorschemes
