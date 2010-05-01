# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="KDE PIM messagelist library"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep messagecore)
"
RDEPEND="${DEPEND}"

add_blocker kmail 4.4.50

KMEXTRA="
	ontologies
"

KMCOMPILEONLY="
	messagecore
"
