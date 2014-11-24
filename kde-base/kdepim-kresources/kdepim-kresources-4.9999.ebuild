# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KMNAME="kdepim"
KMMODULE="kresources"
inherit kde4-meta

DESCRIPTION="KDE PIM groupware plugin collection"
IUSE="debug"
KEYWORDS=""

DEPEND="
	$(add_kdebase_dep kdepimlibs)
	$(add_kdebase_dep kdepim-common-libs)
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	kmail/
	knotes/
	korganizer/version.h
"

KMLOADLIBS="kdepim-common-libs"
