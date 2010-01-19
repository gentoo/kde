# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="KDE PIM messageviewer library"
KEYWORDS=""
IUSE="debug"

DEPEND="
	$(add_kdebase_dep libkdepim)
	$(add_kdebase_dep libkleo)
	$(add_kdebase_dep libkpgp)
	$(add_kdebase_dep messagecore)
"
RDEPEND="${DEPEND}"

add_blocker kmail 4.4.50

KMEXTRACTONLY="
	kresources/groupwise/soap
	libkleo
	libkpgp
	messagecore
"

KMLOADLIBS="
	libkdepim
"
