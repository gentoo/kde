# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KMNAME="kde-runtime"
KMMODULE="plasma"
DECLARATIVE_REQUIRED="always"
inherit kde4-meta

DESCRIPTION="Script engine and package tool for plasma"
KEYWORDS=""
IUSE="debug"

# cloned from workspace thus introduce collisions.
add_blocker plasma-workspace '<4.5.60'
add_blocker kdelibs '<4.5.60'
