# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KMNAME="kde-runtime"
inherit kde4-meta

DESCRIPTION="KDE Password Server"
KEYWORDS=""
IUSE="debug"

DEPEND="
	app-crypt/gpgme
	$(add_kdebase_dep kdepimlibs)
"
RDEPEND="${DEPEND}"

RESTRICT="test"
# testpamopen crashes with a buffer overflow (__fortify_fail)
