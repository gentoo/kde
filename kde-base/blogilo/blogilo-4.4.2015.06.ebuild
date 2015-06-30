# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/blogilo/blogilo-4.4.11.1.ebuild,v 1.11 2014/04/05 18:14:15 dilfridge Exp $

EAPI=5

KMNAME="kdepim"
KDE_HANDBOOK=optional
inherit kde4-meta

DESCRIPTION="KDE Blogging Client (noakonadi branch)"
HOMEPAGE="http://www.kde.org/applications/internet/blogilo"
KEYWORDS=""
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kdepimlibs '' 4.6)
"
RDEPEND="${DEPEND}
	!kde-misc/bilbo
	!kde-misc/blogilo
"
