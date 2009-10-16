# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="KDE PIM messageviewer library"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep libkdepim)
	$(add_kdebase_dep libkleo)
	$(add_kdebase_dep libkpgp)
	$(add_kdebase_dep messagecore)
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	libkleo
	libkpgp
	messagecore
"

PATCHES=(
	"${FILESDIR}"/${PN}-build-fix.patch
)
