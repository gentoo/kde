# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

KMNAME="kdesdk"
inherit kde4-meta

DESCRIPTION="Extra Dolphin plugins"
KEYWORDS=""
IUSE="debug"

DEPEND="
	$(add_kdebase_dep libkonq)
"
RDEPEND="${DEPEND}
	dev-vcs/git
	dev-vcs/subversion
	$(add_kdebase_dep kompare)
"

# SCM plugins moved from dolphin somewhere before 4.4.75
add_blocker dolphin '<4.4.75'

KMLOADLIBS="libkonq"
