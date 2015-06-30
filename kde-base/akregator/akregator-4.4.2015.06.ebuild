# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/akregator/akregator-4.4.11.1-r1.ebuild,v 1.12 2014/08/05 18:17:07 mrueg Exp $

EAPI=5

KMNAME="kdepim"
KDE_HANDBOOK=optional
inherit kde4-meta

DESCRIPTION="KDE news feed aggregator (noakonadi branch)"
HOMEPAGE="http://www.kde.org/applications/internet/akregator"
KEYWORDS=""
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kdelibs '' 4.6)
	$(add_kdebase_dep kdepimlibs '' 4.6)
	$(add_kdebase_dep libkdepim)
"
RDEPEND="${DEPEND}"

KMLOADLIBS="libkdepim"
