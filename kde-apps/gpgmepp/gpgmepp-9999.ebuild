# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5

DESCRIPTION="C++ bindings for gpgme"
KEYWORDS=""
IUSE=""

DEPEND="
	app-crypt/gpgme:=
"
RDEPEND="${DEPEND}
	!kde-base/kdepimlibs:4
"
