# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KMNAME="extragear/multimedia"
inherit kde4-base

DESCRIPTION="KDE CD ripper and audio encoder frontend"
HOMEPAGE="http://kde-apps.org/content/show.php?content=107645"

LICENSE="GPL-2 LGPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep kdemultimedia-kioslaves)
	$(add_kdebase_dep libkcddb)
	$(add_kdebase_dep libkcompactdisc)
	media-libs/libdiscid
	media-libs/taglib
"
DOCS=( Changelog TODO )
