# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim-strigi-analyzer/kdepim-strigi-analyzer-4.4.11.1-r1.ebuild,v 1.4 2015/02/16 08:31:45 ago Exp $

EAPI=5

KMNAME="kdepim"
KMMODULE="strigi-analyzer"
inherit kde4-meta

DESCRIPTION="kdepim: strigi plugins (noakonadi branch)"
KEYWORDS=""
IUSE="debug"

DEPEND="
	app-misc/strigi
	$(add_kdebase_dep kdelibs '' 4.13.1)
	$(add_kdebase_dep kdepimlibs '' 4.6)
"
RDEPEND="${DEPEND}"
