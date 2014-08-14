# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit kde4-meta-pkg

DESCRIPTION="kdeartwork - merge this to pull in all kdeartwork-derived packages"
KEYWORDS=" ~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="minimal"

RDEPEND="
	$(add_kdebase_dep kdeartwork-colorschemes)
	$(add_kdebase_dep kdeartwork-desktopthemes)
	$(add_kdebase_dep kdeartwork-emoticons)
	$(add_kdebase_dep kdeartwork-iconthemes)
	$(add_kdebase_dep kdeartwork-kscreensaver)
	$(add_kdebase_dep kdeartwork-wallpapers)
	$(add_kdebase_dep kdeartwork-weatherwallpapers)
	!minimal? ( $(add_kdebase_dep kdeartwork-styles) )
"
