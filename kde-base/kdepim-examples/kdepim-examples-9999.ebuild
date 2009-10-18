# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdepim"
KMMODULE="examples"
WEBKIT_REQUIRED="always"
inherit kde4-meta

DESCRIPTION="KDE PIM examples"
KEYWORDS=""
IUSE="debug"

DEPEND="
	app-crypt/gpgme
	$(add_kdebase_dep libkdepim)
	$(add_kdebase_dep libkleo)
	$(add_kdebase_dep libkpgp)
	$(add_kdebase_dep messagelist)
	$(add_kdebase_dep messageviewer)
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	akonadi
	messagelist
	messageviewer
"
